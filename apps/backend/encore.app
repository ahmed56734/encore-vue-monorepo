{
	"id":   "my-app",
	"lang": "typescript",
	"build": {
		"hooks": {
			"prebuild": "npx turbo build --filter=@app/backend^..."
		}
	}
}
