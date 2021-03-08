build:
	pub get
	wrangler build
	mkdir -p dist
	dart2js -O2 -o dist/index.js index.dart

publish-prd:
	wrangler publish --env production
