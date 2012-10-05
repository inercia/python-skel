#!/bin/sh

PREFIX=.
BASE=$(dirname $0)

## directories we need in the RPM for running the software
RUN_DIRS="\
          logs \
          run \
          var  var/lib"

## some things we need to put in the RPM for 'building'
RPM_FILES="VERSION \
           RELEASE \
           README.md"
RPM_DIRS="\
         $RUN_DIRS \
         bin conf include lib sbin share share/doc \
         scripts"


## some building stuff...
RPM_TAR=$PREFIX/pkg.tar
IN_RPM_TAR=/inexistent
RPM_BUILD_ROOT=/tmp/XXXX-buildroot
SPEC=
OUT_DIR=

while [ "$1" ]
do
    case $1 in
    --prefix)
        PREFIX=$2
        BASE=$PREFIX/tools/packaging
        shift
        ;;
    --build-root)
        RPM_BUILD_ROOT=$2
        shift
        ;;
    --out-dir)
        OUT_DIR=$2
        shift
        ;;
    --tar)
        RPM_TAR=$2
        shift
        ;;
    --in-tar)
        IN_RPM_TAR=$2
        shift
        ;;
    --spec)
        SPEC=$2
        shift
        ;;
    --help)
        echo "usage: $(basename $0) ARGS"
        echo "where ARGS can be:"
        cat << EOF
    --prefix PREFIX    top installation prefix (default: $PREFIX)
    --build-root DIR   the build root (default: $RPM_BUILD_ROOT)
    --out-dir DIR      directory where the rpm/tgz files will be left (default: the same as the prefix)
    --tar FILE         output RPM tar file (default: $RPM_TAR)
    --spec FILE        RPM spec file
    --in-tar FILE      input tar file that will be expanded in the PREFIX (optional)
    
EOF
        exit 0
        ;;
    *)
        echo "!!! ERROR: unknown parameter $1. Run $(basename $0) --help for getting the command line args"
        exit 1
        ;;
    esac
    shift
done




################################################################################

[ "x$SPEC" != "x" ] || { echo "!!! ERROR: spec file not given. Run $(basename $0) --help for help" ; exit 1 ; }
[ -f $SPEC ] || { echo "!!! ERROR: $SPEC not found. Run $(basename $0) --help for help" ; exit 1 ; }


echo ">>> Saving release number..."
RELEASE=$($PREFIX/buildout/packaging/vcs_version.sh $PREFIX)
echo ">>> ... number: $RELEASE"
echo $RELEASE > $PREFIX/RELEASE

echo ">>> Creating TAR..."
rm -f $RPM_TAR
if [ -f $IN_RPM_TAR ] ; then
    echo ">>> ... untar'ing the input tar file"
    cd $PREFIX && tar -xpf  $IN_RPM_TAR
fi

echo ">>> ... copying spec file"
cp $SPEC $PREFIX/

echo ">>> ... making sure everything is readable by this user..."
find $PREFIX ! -perm -u=r -type f -exec chmod +r '{}' \;

if [ -f $IN_RPM_TAR ] ; then
    echo ">>> ... tar'ing everything"
    cd $PREFIX && tar -cpf  $RPM_TAR *
    RETVAL=$?
    [ $RETVAL -ne 0 ] && exit $RETVAL
else
    for i in $RPM_DIRS ; do
        echo ">>> ... checking directory $i" 
        [ -f $i ] || mkdir -p $i
    done

    echo ">>> ... tar'ing rpm directories"
    cd $PREFIX && tar -cpf  $RPM_TAR      $RPM_DIRS   $RPM_FILES   `basename $SPEC`
    RETVAL=$?
    [ $RETVAL -ne 0 ] && exit $RETVAL
fi

echo ">>> Launching rpmbuild..."
cd $PREFIX && rpmbuild --buildroot    $RPM_BUILD_ROOT  -v -tb $RPM_TAR
RETVAL=$?
[ $RETVAL -ne 0 ] && exit $RETVAL

echo ">>> Saving TAR file..."
rm -f `basename $SPEC`
for i in *.rpm ; do gzip -qc $RPM_TAR  >  `basename $i .rpm`.tgz ; done
RETVAL=$?
[ $RETVAL -ne 0 ] && exit $RETVAL

rm -f $RPM_TAR
rm -f $PREFIX/$SPEC 

if [ "x$OUT_DIR" != "x" ] ; then
    cp $PREFIX/*.rpm $PREFIX/*.tgz   $OUT_DIR/
fi


echo ">>> rpm creation has been SUCCESSFUL !!"
exit 0







