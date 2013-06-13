#!/bin/sh

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy.txt
touch "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "rsync -rp ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -rp "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
install_resource 'Facebook-iOS-SDK/src/FacebookSDKResources.bundle'
install_resource 'REComposeViewController/REComposeViewController/REComposeViewController.bundle'
install_resource 'ShareThis/Assets/Instapaper-Icon.png'
install_resource 'ShareThis/Assets/Instapaper-Icon@2x.png'
install_resource 'ShareThis/Assets/Pocket-Icon.png'
install_resource 'ShareThis/Assets/Pocket-Icon@2x.png'
install_resource 'ShareThis/Assets/Readability-Icon.png'
install_resource 'ShareThis/Assets/Readability-Icon@2x.png'
install_resource 'VideoPlayerKit/Assets/airplay-display.png'
install_resource 'VideoPlayerKit/Assets/airplay-display@2x.png'
install_resource 'VideoPlayerKit/Assets/fullscreen-button.png'
install_resource 'VideoPlayerKit/Assets/fullscreen-button@2x.png'
install_resource 'VideoPlayerKit/Assets/minimize-button.png'
install_resource 'VideoPlayerKit/Assets/minimize-button@2x.png'
install_resource 'VideoPlayerKit/Assets/pause-button.png'
install_resource 'VideoPlayerKit/Assets/pause-button@2x.png'
install_resource 'VideoPlayerKit/Assets/play-button.png'
install_resource 'VideoPlayerKit/Assets/play-button@2x.png'
install_resource 'VideoPlayerKit/Assets/share-button.png'
install_resource 'VideoPlayerKit/Assets/share-button@2x.png'
install_resource 'VideoPlayerKit/Assets/transparentBar.png'
install_resource 'VideoPlayerKit/Assets/transparentBar@2x.png'

rsync -avr --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rm "$RESOURCES_TO_COPY"
