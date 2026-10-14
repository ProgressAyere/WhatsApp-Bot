const mongoose = require('mongoose');
const { BufferJSON, initAuthCreds } = require('@whiskeysockets/baileys');

const authSchema = new mongoose.Schema({
    _id: String,
    value: Object
});

const AuthModel = mongoose.models.AuthState || mongoose.model('AuthState', authSchema);

async function connectMongo() {
    if (mongoose.connection.readyState === 0) {
        await mongoose.connect(process.env.MONGODB_URI);
        console.log('✅ Connected to MongoDB');
    }
}

async function useMongoAuthState() {
    await connectMongo();

    const writeData = async (id, value) => {
        await AuthModel.findByIdAndUpdate(
            id,
            { value: JSON.parse(JSON.stringify(value, BufferJSON.replacer)) },
            { upsert: true }
        );
    };

    const readData = async (id) => {
        const doc = await AuthModel.findById(id);
        if (!doc) return null;
        return JSON.parse(JSON.stringify(doc.value), BufferJSON.reviver);
    };

    const removeData = async (id) => {
        await AuthModel.findByIdAndDelete(id);
    };

    const creds = (await readData('creds')) || initAuthCreds();

    return {
        state: {
            creds,
            keys: {
                get: async (type, ids) => {
                    const data = {};
                    await Promise.all(
                        ids.map(async (id) => {
                            const value = await readData(`${type}-${id}`);
                            if (value) data[id] = value;
                        })
                    );
                    return data;
                },
                set: async (data) => {
                    await Promise.all(
                        Object.entries(data).flatMap(([type, entries]) =>
                            Object.entries(entries).map(([id, value]) =>
                                value ? writeData(`${type}-${id}`, value) : removeData(`${type}-${id}`)
                            )
                        )
                    );
                }
            }
        },
        saveCreds: () => writeData('creds', creds)
    };
}

module.exports = { useMongoAuthState };
