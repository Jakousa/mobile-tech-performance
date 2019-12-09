const sirv = require('sirv');
const polka = require('polka');
const compress = require('compression')();

// Init `sirv` handler
const assets = sirv('public', {
    maxAge: 31536000, // 1Y
    immutable: true
});

const PORT = process.env.PORT || 3000;


polka()
    .use(compress, assets)
    .listen(PORT, () => console.log("Running on, ", PORT))