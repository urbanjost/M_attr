#!/bin/bash
cd $(dirname $0)
rm -rfv ../source/doc
export GITHUB=TRUE
export DEMO_OUTDIR=../../example/
export DEMO_SUBDIR=TRUE
export DEMO_SUBDIR=FALSE
GPF_build_module M_attr
cp ../../docs/man3.html ../../docs/index.html
cp ../../docs/BOOK_M_attr.html ../../docs/index.html
ccall ../../test/test_suite_M_attr.[fF]90
exit
