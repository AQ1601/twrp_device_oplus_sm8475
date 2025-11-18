#!/sbin/sh

variant="$(getprop ro.boot.prjname)"

log_file="/dev/kmsg"

log() {
    echo "variant-script.sh: $1" | tee -a "$log_file"
    echo "variant-script.sh: $1" | tee -a /tmp/recovery.log
}

umount -f -l /system
log "/system unmounted"
umount -f -l /vendor
log "/vendor unmounted"
umount -f -l /odm
log "/odm unmounted"

set_oneplus_common() {
    local usb_name="$1"
    local product_name="$2"
    local device_code="$3"
    local region="$4"
    local spr_value="$5"

    echo "$usb_name" > /config/usb_gadget/g1/strings/0x409/product

    resetprop ro.product.brand "OnePlus"
    resetprop ro.product.manufacturer "OnePlus"
    resetprop vendor.display.enable_spr "$spr_value"
    resetprop ro.product.name "$product_name"
    resetprop ro.product.device "$device_code"
    resetprop ro.product.system.device "$product_name"
    resetprop ro.product.vendor.device "$device_code"
    resetprop ro.product.odm.device "$device_code"
    resetprop ro.product.product.device "$device_code"
    resetprop ro.product.system_ext.device "$device_code"
    resetprop ro.product.product.model "$product_name"
    resetprop ro.product.model "$product_name"
    resetprop ro.product.system.model "$product_name"
    resetprop ro.product.system_ext.model "$product_name"
    resetprop ro.product.vendor.model "$product_name"
    resetprop ro.product.odm.model "$product_name"
    resetprop ro.boot.hardware.revision "$region"
    log "Variant $usb_name ($product_name) properties all set."
}

case "$variant" in
    "24821")
        # OnePlus ACE 5 (giulia)
        set_oneplus_common "Oneplus ACE Pro" "PGP110" "OP5551L1" "CN" "0"
        ;;

    *)
        # Unknown variant
        log "Unknown variant: $variant"
        ;;
esac

device="$(getprop ro.product.device)"

case "$device" in
    "OP5CFBL1")
        # OnePlus ACE 3v (audi)
        cp -rf /vendor/variant/audi/vendor/* /vendor
        ;;

    "OP5E93L1")
        # OnePlus NORD 4 (audi)
        cp -rf /vendor/variant/audi/vendor/* /vendor
        ;;

    *)
        # No need to copy files device
        device="$(cat /config/usb_gadget/g1/strings/0x409/product)"
        log "No need to copy files for variant: $device"
        ;;
esac

log "twrp.variant.files_copied"

resetprop twrp.variant.files_copied "1"

exit 0
