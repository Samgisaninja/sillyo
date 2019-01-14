include $(THEOS)/makefiles/common.mk

TWEAK_NAME = sillyo
sillyo_FILES = Tweak.xm
sillyo_FRAMEWORKS = WebKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Sileo"
