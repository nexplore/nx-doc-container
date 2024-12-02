pandoc \
  --pdf-engine=xelatex \
  --to=pdf \
  --toc-depth=3 \
  --lua-filter=include-files.lua \
  -o ../docs/doc.pdf \
  ../docs/index.md \
  --resource-path ../docs/ \
  --extract-media=../docs/ \
  --metadata title="Sample report" \
  --metadata author="Nexplore AG" \
  --metadata=toc-title:"Table of content" \
  --toc \
  -V mainfont="FreeSans" \
  -V geometry:margin=1in \
  -V fontsize=12pt \
  -V documentclass=scrartcl \
  -V colorlinks=true \
  -V linkcolor=blue \
  -V footer-center="Page \thepage"