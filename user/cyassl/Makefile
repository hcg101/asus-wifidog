SRC_NAME=cyassl-3.3.0

CFLAGS+=$(COPT) -ffunction-sections -fdata-sections
LDFLAGS += -Wl,--gc-sections

THISDIR = $(shell pwd)

all: config_test
	uzip cyassl-3.3.0.zip
	$(MAKE) -C $(SRC_NAME) && \
	$(MAKE) -C $(SRC_NAME) install DESTDIR=$(THISDIR)/install
	#libtool --finish $(INSTALLDIR)/usr/lib
config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

configure:
	( cd $(SRC_NAME) ; \
	#HAVE_CXX=yes \
	#PKG_CONFIG_PATH=$(STAGEDIR)/lib/pkgconfig \
	#./autogen.sh  \
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--enable-cyassl \
		--host=$(HOST_TARGET) \
		--build=$(HOST_BUILD) ; \
	)
clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) distclean ; \
	fi ; \
	rm -f config_done
	rm -rf install

romfs:
	mkdir -p $(INSTALLDIR)/usr/include/cyassl
	mkdir -p $(INSTALLDIR)/usr/share/doc
	mkdir -p $(INSTALLDIR)/etc
	$(ROMFSINST) $(THISDIR)/install/usr/bin/cyassl-config	/usr/bin/cyassl-config
	cp -rf  $(THISDIR)/install/usr/include/cyassl/	$(INSTALLDIR)/usr/include/
	cp -rf  $(THISDIR)/install/usr/share/doc/cyassl	$(INSTALLDIR)/usr/share/doc/	
	#cp -rf  $(THISDIR)/libgcc_s.so.1	$(INSTALLDIR)/usr/lib/libgcc_s.so.1
	#cp -rf  $(THISDIR)/kmsserver.ini	$(INSTALLDIR)/usr/bin/kmsserver.ini
	#cp -rf  $(THISDIR)/kmsserver.pid	$(INSTALLDIR)/usr/bin/kmsserver.pid
	$(ROMFSINST) $(THISDIR)/install/usr/lib/libcyassl.la	/usr/lib/libcyassl.la
	$(ROMFSINST) $(THISDIR)/install/usr/lib/libcyassl.so	/usr/lib/libcyassl.so
	#$(ROMFSINST) $(THISDIR)/install/usr/include/wifidog/httpd.h	/usr/include/wifidog/httpd.h
	$(ROMFSINST) $(THISDIR)/install/usr/lib/libcyassl.so.5	/usr/lib/libcyassl.so.5
	$(ROMFSINST) $(THISDIR)/install/usr/lib/libcyassl.so.5.1.0	/usr/libcyassl.so.5.1.0
	#$(ROMFSINST) $(THISDIR)/install/usr/lib/libhttpd.so.0.0.0	/usr/lib/libhttpd.so.0.0.0
	
	#$(ROMFSINST) -p +x /usr/bin/wifidog.sh
		
