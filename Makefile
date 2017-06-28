
.PHONY: all minify validate validate-html validate-css clean

all: index.html style/screen.min.css validate

minify: index.html style/screen.min.css

index.html:
	cat _index.html | \
	sed 's/screen\.css/screen.min.css/' | \
	html-minifier --collapse-boolean-attributes \
								--collapse-whitespace \
								--decode-entities \
								--html5 \
								--remove-attribute-quotes \
								--remove-comments \
								--remove-empty-attributes \
								--remove-optional-tags \
								--remove-redundant-attributes \
								--remove-script-type-attributes \
								--remove-style-link-type-attributes \
								--remove-tag-whitespace \
								--use-short-doctype \
								> \
	index.html

style/screen.min.css:
	csso style/screen.css style/screen.min.css

validate: validate-html validate-css

validate-html: _index.html index.html
	tidy -errors -quiet _index.html index.html

validate-css: style/screen.css style/screen.min.css
	css-validator style/screen.css style/screen.min.css

clean:
	rm -f index.html style/screen.min.css
	
