LIBRESSL_VERSION = 2.1.4

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
			--host i386-linux-gnu CFLAGS="$(OSSL_CFLAGS)" LDFLAGS="-Wl,--hash-style=sysv")
	sed -i -e s^"libcompatnoopt_la_CFLAGS = -O0"^"libcompatnoopt_la_CFLAGS = $(OSSL_CFLAGS) -O0"^ \
		$(build_tmp)/libressl-$(LIBRESSL_VERSION)/crypto/Makefile
	@(cd $(build_tmp)/libressl-$(LIBRESSL_VERSION) && $(MAKE))

clean-ssl:
	rm -fr $(build_tmp)/libressl-$(LIBRESSL_VERSION) \
		$(COMPILED)/libcrypto.so $(COMPILED)/libssl.so
