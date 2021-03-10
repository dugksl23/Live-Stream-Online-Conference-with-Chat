const env = process.env.NODE_ENV || 'production'

//insert your API Key & Secret for each environment, keep this file local and never push it to a public repo for security purposes.
const config = {
	development :{
		APIKey : 'Xe3GR-3PR72qMsP_WS9Elw',
		APISecret : 'OG2F7NFlAuVok8NIjd9B0xub8YzuFEqPeL1l'
	},
	production:{	
		APIKey : 'Xe3GR-3PR72qMsP_WS9Elw',
		APISecret : 'OG2F7NFlAuVok8NIjd9B0xub8YzuFEqPeL1l'
	}
};

module.exports = config[env]
