LIBRESSL_VERSION = 2.1.6
LIBRESSL_MIRROR=ftp://ftp5.usa.openbsd.org/pub/OpenBSD/LibreSSL/
LIBRESSL_WIN=libressl-$(LIBRESSL_VERSION)-windows
LIBRESSL_CRYPTO_VER=32
LIBRESSL_SSL_VER=32

update: libressl-$(LIBRESSL_VERSION).tar.gz libressl-$(LIBRESSL_VERSION)-windows.zip
	rm -fr $(LIBRESSL_WIN)
	unzip $(LIBRESSL_WIN).zip
	rsync -a --delete $(LIBRESSL_WIN)/include/openssl/ include/openssl/
	cp $(LIBRESSL_WIN)/x86/libcrypto-$(LIBRESSL_CRYPTO_VER).lib lib/win/libeay32.lib
	cp $(LIBRESSL_WIN)/x86/libssl-$(LIBRESSL_SSL_VER).lib lib/win/ssleay32.lib
	cp $(LIBRESSL_WIN)/x64/libcrypto-$(LIBRESSL_CRYPTO_VER).lib lib/win/x64/libeay32.lib
	cp $(LIBRESSL_WIN)/x64/libssl-$(LIBRESSL_SSL_VER).lib lib/win/x64/ssleay32.lib

libressl-$(LIBRESSL_VERSION).tar.gz:
	wget $(LIBRESSL_MIRROR)/libressl-$(LIBRESSL_VERSION).tar.gz

libressl-$(LIBRESSL_VERSION)-windows.zip:
	wget $(LIBRESSL_MIRROR)/libressl-$(LIBRESSL_VERSION)-windows.zip

$(COMPILED)/libcrypto.so: \
	$(build_tmp)/libressl-$(LIBRESSL_VERSION)/ssl/.libs/libssl.so
	@echo Installing libcrypto
	@cp $(build_tmp)/libressl-$(LIBRESSL_VERSION)/crypto/.libs/libcrypto.so \
		$(COMPILED)/libcrypto.so

$(COMPILED)/libssl.so: \
	$(build_tmp)/libressl-$(LIBRESSL_VERSION)/ssl/.libs/libssl.so
	@echo Installing libssl
	@cp $(build_tmp)/libressl-$(LIBRESSL_VERSION)/ssl/.libs/libssl.so \
		$(COMPILED)/libssl.so

$(build_tmp)/libressl-$(LIBRESSL_VERSION)/ssl/.libs/libssl.so:
	@echo Building LibreSSL
	@[ -d $(build_tmp) ] || mkdir $(build_tmp)
	@[ -d $(build_tmp)/libressl-$(LIBRESSL_VERSION) ] || \
		tar -C $(build_tmp)/ -xzf $(cwd)/deps/libressl/libressl-$(LIBRESSL_VERSION).tar.gz && \
		cp $(cwd)/deps/libressl/stddef.h \
			$(build_tmp)/libressl-$(LIBRESSL_VERSION)/include/ && \
		cp $(cwd)/deps/libressl/issetugid_linux.c \
			$(build_tmp)/libressl-$(LIBRESSL_VERSION)/crypto/compat
		cp $(cwd)/deps/libressl/getentropy_linux.c \
			$(build_tmp)/libressl-$(LIBRESSL_VERSION)/crypto/compat
	@(cd $(build_tmp)/libressl-$(LIBRESSL_VERSION) && \
		./configure --prefix=/tmp/out --disable-asm --disable-hardening \
			ac_cv_header_sys_sysctl_h=no \
			--host i386-linux-gnu CFLAGS="$(OSSL_CFLAGS)" LDFLAGS="-Wl,--hash-style=sysv" > build.log)
	sed -i -e s^"libcompatnoopt_la_CFLAGS = -O0"^"libcompatnoopt_la_CFLAGS = $(OSSL_CFLAGS) -O0"^ \
		$(build_tmp)/libressl-$(LIBRESSL_VERSION)/crypto/Makefile
	@(cd $(build_tmp)/libressl-$(LIBRESSL_VERSION) && $(MAKE) >> build.log)

clean-ssl:
	rm -fr $(build_tmp)/libressl-$(LIBRESSL_VERSION) \
		$(COMPILED)/libcrypto.so $(COMPILED)/libssl.so
