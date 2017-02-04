SRC_NAME=

CFLAGS+=$(COPT) -ffunction-sections -fdata-sections
LDFLAGS += -Wl,--gc-sections

THISDIR = $(shell pwd)

all: config_test
	#$(MAKE) -C $(SRC_NAME) && \
	#$(MAKE) -C $(SRC_NAME) install DESTDIR=$(THISDIR)/install

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

configure:
	#( cd $(SRC_NAME) ; \
	#HAVE_CXX=yes \
	#PKG_CONFIG_PATH=$(STAGEDIR)/lib/pkgconfig \
	#./autogen.sh  \
	#./configure \
	#	--prefix=/usr \
	#	--sysconfdir=/etc \
	#	--host=$(HOST_TARGET) \
	#	--build=$(HOST_BUILD) ; \
	#)
clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) distclean ; \
	fi ; \
	rm -f config_done
	rm -rf install

romfs:
	#mkdir -p $(INSTALLDIR)/usr/include/wifidog
	#mkdir -p $(INSTALLDIR)/etc
	$(ROMFSINST) $(THISDIR)/ngrok	/usr/bin/ngrok
	$(ROMFSINST) $(THISDIR)/ngrok.sh	/usr/bin/ngrok.sh
	$(ROMFSINST) $(THISDIR)/checkngrok.sh	/usr/bin/checkngrok.sh
		$(ROMFSINST) -p +x /usr/bin/ngrok.sh
		
