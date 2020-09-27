call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar/path/to/google-java-format-VERSION-all-deps.jar"
augroup autoformat_settings
		autocmd FileType bzl AutoFormatBuffer buildifier
		autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
		autocmd FileType dart AutoFormatBuffer dartfmt
		autocmd FileType go AutoFormatBuffer gofmt
		autocmd FileType gn AutoFormatBuffer gn
		autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
		autocmd FileType java AutoFormatBuffer google-java-format
		autocmd FileType python AutoFormatBuffer yapf
		autocmd FileType python3 AutoFormatBuffer yapf
		autocmd FileType rust AutoFormatBuffer rustfmt
		autocmd FileType vue AutoFormatBuffer prettier
augroup END
