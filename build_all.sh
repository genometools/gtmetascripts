#!/bin/sh -ex

DISTDIR=$HOME/work/distall
rm -rf $DISTDIR
mkdir -p $DISTDIR
TMPFILE=`mktemp` || exit 1

# Linux 32-bit
cd genometools
make 32bit=yes cairo=no m32=yes MACHINE=i386 \
     CPPFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -D_GNU_SOURCE' cleanup
make 32bit=yes cairo=no m32=yes MACHINE=i386 \
     CPPFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -D_GNU_SOURCE' $*
make 32bit=yes cairo=no m32=yes MACHINE=i386 \
     CPPFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -D_GNU_SOURCE' manuals
make 32bit=yes cairo=no m32=yes MACHINE=i386 \
     CPPFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -D_GNU_SOURCE' dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..

cd vstree/src
mklink.sh linux-gcc
make MACHINE=i386 cleanup
make MACHINE=i386 licensemanager=no $*
make MACHINE=i386 licensemanager=no STRIP=strip dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ../..

cd genomethreader
make m32=yes MACHINE=i386 cleanup
make m32=yes MACHINE=i386 licensemanager=no amalgamation=yes $*
make m32=yes MACHINE=i386 licensemanager=no amalgamation=yes train $*
make m32=yes MACHINE=i386 licensemanager=no amalgamation=yes dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..


# Linux 64-bit
cd genometools
make clean
make wrapmemcpy=yes \
     CPPFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -D_GNU_SOURCE' \
     cairo=no $*
make wrapmemcpy=yes \
     CPPFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -D_GNU_SOURCE' \
     cairo=no dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..

cd vstree/src
mklink.sh linux-gcc-64
make cleanup
make 64bit=yes \
     wrapmemcpy=yes \
     licensemanager=no \
     $*
make 64bit=yes \
     wrapmemcpy=yes \
     licensemanager=no \
     dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ../..

cd genomethreader
make clean
make 64bit=yes \
     wrapmemcpy=yes \
     licensemanager=no \
     amalgamation=yes $*
make 64bit=yes \
     wrapmemcpy=yes \
     licensemanager=no \
     amalgamation=yes dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..


# PowerPCle
cd genometools
make clean
make MACHINE=PowerPCle \
     CC="ccache powerpc64le-linux-gnu-gcc" \
     AR=powerpc64le-linux-gnu-ar \
     STRIP=powerpc64le-linux-gnu-strip \
     cairo=no $*
make MACHINE=PowerPCle \
     CC="ccache powerpc64le-linux-gnu-gcc" \
     AR=powerpc64le-linux-gnu-ar \
     STRIP=powerpc64le-linux-gnu-strip \
     cairo=no dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..

cd vstree/src
mklink.sh linux-gcc-64
make cleanup
make MACHINE=PowerPCle \
     64bit=yes \
     CC="ccache powerpc64le-linux-gnu-gcc" \
     AR=powerpc64le-linux-gnu-ar \
     RANLIB=powerpc64le-linux-gnu-ranlib \
     licensemanager=no \
     $*
make MACHINE=PowerPCle \
     64bit=yes \
     CC="ccache powerpc64le-linux-gnu-gcc" \
     AR=powerpc64le-linux-gnu-ar \
     RANLIB=powerpc64le-linux-gnu-ranlib \
     STRIP=powerpc64le-linux-gnu-strip \
     licensemanager=no \
     dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ../..

cd genomethreader
make clean
make MACHINE=PowerPCle \
     64bit=yes \
     CC="ccache powerpc64le-linux-gnu-gcc" \
     AR=powerpc64le-linux-gnu-ar \
     STRIP=powerpc64le-linux-gnu-strip \
     licensemanager=no \
     amalgamation=yes $*
make MACHINE=PowerPCle \
     64bit=yes \
     CC="ccache powerpc64le-linux-gnu-gcc" \
     AR=powerpc64le-linux-gnu-ar \
     STRIP=powerpc64le-linux-gnu-strip \
     licensemanager=no \
     amalgamation=yes dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..


# ARMv7_hf
cd genometools
make clean
make 32bit=yes \
     MACHINE=ARMv7_hf \
     CC="ccache arm-linux-gnueabihf-gcc" \
     AR=arm-linux-gnueabihf-ar \
     STRIP=arm-linux-gnueabihf-strip \
     cairo=no $*
make 32bit=yes \
     MACHINE=ARMv7_hf \
     CC="ccache arm-linux-gnueabihf-gcc" \
     AR=arm-linux-gnueabihf-ar \
     STRIP=arm-linux-gnueabihf-strip \
     cairo=no dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..

cd vstree/src
mklink.sh linux-arm
make cleanup
make MACHINE=ARMv7_hf \
     CC="ccache arm-linux-gnueabihf-gcc" \
     AR=arm-linux-gnueabihf-ar \
     RANLIB=arm-linux-gnueabihf-ranlib \
     licensemanager=no \
     $*
make MACHINE=ARMv7_hf \
     CC="ccache arm-linux-gnueabihf-gcc" \
     AR=arm-linux-gnueabihf-ar \
     RANLIB=arm-linux-gnueabihf-ranlib \
     STRIP=arm-linux-gnueabihf-strip \
     licensemanager=no \
     dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ../..

cd genomethreader
make clean
make MACHINE=ARMv7_hf \
     CC="ccache arm-linux-gnueabihf-gcc" \
     AR=arm-linux-gnueabihf-ar \
     STRIP=arm-linux-gnueabihf-strip \
     licensemanager=no \
     amalgamation=yes $*
make MACHINE=ARMv7_hf \
     CC="ccache arm-linux-gnueabihf-gcc" \
     AR=arm-linux-gnueabihf-ar \
     STRIP=arm-linux-gnueabihf-strip \
     licensemanager=no \
     amalgamation=yes dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..


# ARMv7_el
cd genometools
make clean
make 32bit=yes \
     MACHINE=ARMv7_el \
     CC="ccache arm-linux-gnueabi-gcc" \
     AR=arm-linux-gnueabi-ar \
     STRIP=arm-linux-gnueabi-strip \
     cairo=no $*
make 32bit=yes \
     MACHINE=ARMv7_el \
     CC="ccache arm-linux-gnueabi-gcc" \
     AR=arm-linux-gnueabi-ar \
     STRIP=arm-linux-gnueabi-strip \
     cairo=no dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..

cd vstree/src
mklink.sh linux-arm
make cleanup
make MACHINE=ARMv7_el \
     CC="ccache arm-linux-gnueabi-gcc" \
     AR=arm-linux-gnueabi-ar \
     RANLIB=arm-linux-gnueabi-ranlib \
     licensemanager=no \
     $*
make MACHINE=ARMv7_el \
     CC="ccache arm-linux-gnueabi-gcc" \
     AR=arm-linux-gnueabi-ar \
     RANLIB=arm-linux-gnueabi-ranlib \
     STRIP=arm-linux-gnueabi-strip \
     licensemanager=no \
     dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ../..

cd genomethreader
make clean
make MACHINE=ARMv7_el \
     CC="ccache arm-linux-gnueabi-gcc" \
     AR=arm-linux-gnueabi-ar \
     STRIP=arm-linux-gnueabi-strip \
     licensemanager=no \
     amalgamation=yes $*
make MACHINE=ARMv7_el \
     CC="ccache arm-linux-gnueabi-gcc" \
     AR=arm-linux-gnueabi-ar \
     STRIP=arm-linux-gnueabi-strip \
     licensemanager=no \
     amalgamation=yes dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..


# ARMv6_hf
ARMV6=$HOME/arm/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf

cd genometools
make clean
make 32bit=yes \
     MACHINE=ARMv6_hf \
     CC="ccache ${ARMV6}-gcc" \
     AR=${ARMV6}-ar \
     STRIP=${ARMV6}-strip \
     cairo=no $*
make 32bit=yes \
     MACHINE=ARMv6_hf \
     CC="ccache ${ARMV6}-gcc" \
     AR=${ARMV6}-ar \
     STRIP=${ARMV6}-strip \
     cairo=no dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..

cd vstree/src
mklink.sh linux-arm
make cleanup
make MACHINE=ARMv6_hf \
     CC="ccache ${ARMV6}-gcc" \
     AR=${ARMV6}-ar \
     RANLIB=${ARMV6}-ranlib \
     licensemanager=no \
     $*
make MACHINE=ARMv6_hf \
     CC="ccache ${ARMV6}-gcc" \
     AR=${ARMV6}-ar \
     RANLIB=${ARMV6}-ranlib \
     STRIP=${ARMV6}-strip \
     licensemanager=no \
     dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ../..

cd genomethreader
make clean
make MACHINE=ARMv6_hf \
     CC="ccache ${ARMV6}-gcc" \
     AR=${ARMV6}-ar \
     STRIP=${ARMV6}-strip \
     licensemanager=no \
     amalgamation=yes $*
make MACHINE=ARMv6_hf \
     CC="ccache ${ARMV6}-gcc" \
     AR=${ARMV6}-ar \
     STRIP=${ARMV6}-strip \
     licensemanager=no \
     amalgamation=yes dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..


# Darwin 32-bit
cd genometools
make clean
make 32bit=yes \
     SYSTEM=Darwin\
     MACHINE=i386 \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     cairo=no $*
make 32bit=yes \
     SYSTEM=Darwin\
     MACHINE=i386 \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     cairo=no dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..

cd vstree/src
mklink.sh osx-gcc
make cleanup
make SYSTEM=Darwin\
     MACHINE=i386 \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     licensemanager=no \
     $*
make SYSTEM=Darwin\
     MACHINE=i386 \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     licensemanager=no \
     dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ../..

cd genomethreader
make clean
make SYSTEM=Darwin\
     MACHINE=i386 \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     licensemanager=no \
     amalgamation=yes $*
make SYSTEM=Darwin\
     MACHINE=i386 \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     licensemanager=no \
     amalgamation=yes dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..


# Darwin 64-bit
cd genometools
make clean
make SYSTEM=Darwin\
     MACHINE=i386 \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     cairo=no $*
make SYSTEM=Darwin\
     MACHINE=i386 \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     cairo=no dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..

cd vstree/src
mklink.sh osx-gcc-64
make cleanup
make SYSTEM=Darwin\
     MACHINE=i386 \
     64bit=yes \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     licensemanager=no \
     $*
make SYSTEM=Darwin\
     MACHINE=i386 \
     64bit=yes \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     licensemanager=no \
     dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ../..

cd genomethreader
make clean
make SYSTEM=Darwin\
     MACHINE=i386 \
     64bit=yes \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     licensemanager=no \
     amalgamation=yes $*
make SYSTEM=Darwin\
     MACHINE=i386 \
     64bit=yes \
     CC=i686-apple-darwin10-gcc \
     AR=i686-apple-darwin10-ar \
     RANLIB=i686-apple-darwin10-ranlib \
     STRIP=i686-apple-darwin10-strip \
     licensemanager=no \
     amalgamation=yes dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..


# Windows 32-bit
cd genometools
make clean
make 32bit=yes \
     SYSTEM=Windows\
     MACHINE=i686 \
     CC=i686-w64-mingw32-gcc \
     AR=i686-w64-mingw32-ar \
     RANLIB=i686-w64-mingw32-ranlib \
     STRIP=i686-w64-mingw32-strip \
     fpic=no \
     sharedlib=no                                               \
     CFLAGS='-Wno-error=attributes -Wno-error=unused-parameter -DSQLITE_MALLOCSIZE=_msize' \
     cairo=no $*
make 32bit=yes \
     SYSTEM=Windows\
     MACHINE=i686 \
     CC=i686-w64-mingw32-gcc \
     AR=i686-w64-mingw32-ar \
     RANLIB=i686-w64-mingw32-ranlib \
     STRIP=i686-w64-mingw32-strip \
     fpic=no \
     sharedlib=no                                               \
     CFLAGS='-Wno-error=attributes -Wno-error=unused-parameter -DSQLITE_MALLOCSIZE=_msize' \
     cairo=no lib/libexpat.a dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..

cd vstree/src
mklink.sh windows-mingw
make cleanup
make SYSTEM=Windows\
     MACHINE=i686 \
     CC=i686-w64-mingw32-gcc \
     AR=i686-w64-mingw32-ar \
     RANLIB=i686-w64-mingw32-ranlib \
     STRIP=i686-w64-mingw32-strip \
     licensemanager=no \
     $*
make SYSTEM=Windows\
     MACHINE=i686 \
     CC=i686-w64-mingw32-gcc \
     AR=i686-w64-mingw32-ar \
     RANLIB=i686-w64-mingw32-ranlib \
     STRIP=i686-w64-mingw32-strip \
     licensemanager=no \
     dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ../..

cd genomethreader
make clean
make SYSTEM=Windows\
     MACHINE=i686 \
     CC=i686-w64-mingw32-gcc \
     AR=i686-w64-mingw32-ar \
     RANLIB=i686-w64-mingw32-ranlib \
     STRIP=i686-w64-mingw32-strip \
     fpic=no \
     licensemanager=no \
     amalgamation=yes $*
make SYSTEM=Windows\
     MACHINE=i686 \
     CC=i686-w64-mingw32-gcc \
     AR=i686-w64-mingw32-ar \
     RANLIB=i686-w64-mingw32-ranlib \
     STRIP=i686-w64-mingw32-strip \
     fpic=no \
     licensemanager=no \
     amalgamation=yes dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..


# Windows 64-bit
cd genometools
make clean
make SYSTEM=Windows\
     MACHINE=i686 \
     CC=x86_64-w64-mingw32-gcc \
     AR=x86_64-w64-mingw32-ar \
     RANLIB=x86_64-w64-mingw32-ranlib \
     STRIP=x86_64-w64-mingw32-strip \
     fpic=no \
     sharedlib=no                                               \
     CFLAGS='-Wno-error=attributes -Wno-error=unused-parameter -DSQLITE_MALLOCSIZE=_msize' \
     cairo=no $*
make SYSTEM=Windows\
     MACHINE=i686 \
     CC=x86_64-w64-mingw32-gcc \
     AR=x86_64-w64-mingw32-ar \
     RANLIB=x86_64-w64-mingw32-ranlib \
     STRIP=x86_64-w64-mingw32-strip \
     fpic=no \
     sharedlib=no                                               \
     CFLAGS='-Wno-error=attributes -Wno-error=unused-parameter -DSQLITE_MALLOCSIZE=_msize' \
     cairo=no lib/libexpat.a dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..

cd vstree/src
mklink.sh windows-mingw-64
make cleanup
make SYSTEM=Windows\
     MACHINE=i686 \
     64bit=yes \
     CC=x86_64-w64-mingw32-gcc \
     AR=x86_64-w64-mingw32-ar \
     RANLIB=x86_64-w64-mingw32-ranlib \
     STRIP=x86_64-w64-mingw32-strip \
     licensemanager=no \
     $*
make SYSTEM=Windows\
     MACHINE=i686 \
     64bit=yes \
     CC=x86_64-w64-mingw32-gcc \
     AR=x86_64-w64-mingw32-ar \
     RANLIB=x86_64-w64-mingw32-ranlib \
     STRIP=x86_64-w64-mingw32-strip \
     licensemanager=no \
     dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ../..

cd genomethreader
make clean
make SYSTEM=Windows\
     MACHINE=i686 \
     64bit=yes \
     CC=x86_64-w64-mingw32-gcc \
     AR=x86_64-w64-mingw32-ar \
     RANLIB=x86_64-w64-mingw32-ranlib \
     STRIP=x86_64-w64-mingw32-strip \
     fpic=no \
     licensemanager=no \
     amalgamation=yes $*
make SYSTEM=Windows\
     MACHINE=i686 \
     64bit=yes \
     CC=x86_64-w64-mingw32-gcc \
     AR=x86_64-w64-mingw32-ar \
     RANLIB=x86_64-w64-mingw32-ranlib \
     STRIP=x86_64-w64-mingw32-strip \
     fpic=no \
     licensemanager=no \
     amalgamation=yes dist > $TMPFILE
DISTRIBUTION=`tail -n 1 $TMPFILE`
cp -f $DISTRIBUTION $DISTDIR
cd ..
