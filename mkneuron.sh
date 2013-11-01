#!/bin/sh
set -e

BASEPREFIX=/opt/neuron

wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.3/nrn-7.3.tar.gz
wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.3/iv-18.tar.gz

tar xzf iv-18.tar.gz
tar xzf nrn-7.3.tar.gz

( cd iv-18 ;
  ./configure --prefix=$BASEPREFIX/iv ;
  make -j 50 ;
  checkinstall --pkgname=neuron-iv
  )

( cd nrn-7.3 ;
  ./configure --prefix=$BASEPREFIX/nrn --with-iv=$BASEPREFIX/iv --with-nrnpython=/usr/bin/python --with-numpy ;
  make -j 50 ;

  test -z "$BASEPREFIX/nrn/x86_64/lib" || /bin/mkdir -p "$BASEPREFIX/nrn/x86_64/lib" ;
  test -z "$BASEPREFIX/nrn/include/nrn" || /bin/mkdir -p "$BASEPREFIX/nrn/include/nrn" ;
  test -z "$BASEPREFIX/nrn/share/nrn/lib/auditscripts" || /bin/mkdir -p "$BASEPREFIX/nrn/share/nrn/lib/auditscripts" ;
  test -z "$BASEPREFIX/nrn/share/nrn/lib/hoc/celbild" || /bin/mkdir -p "$BASEPREFIX/nrn/share/nrn/lib/hoc/celbild" ;
  test -z "$BASEPREFIX/nrn/share/nrn/examples/nrniv/netcon" || /bin/mkdir -p "$BASEPREFIX/nrn/share/nrn/examples/nrniv/netcon" ;
  test -z "$BASEPREFIX/nrn/share/nrn/demo/release" || /bin/mkdir -p "$BASEPREFIX/nrn/share/nrn/demo/release" ;

  checkinstall --pkgname=neuron-nrn
  )

