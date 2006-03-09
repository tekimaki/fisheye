<?php
/**
 * @version $Header: /cvsroot/bitweaver/_bit_fisheye/view_image.php,v 1.1.1.1.2.3 2006/03/09 17:47:34 spiderr Exp $
 * @package fisheye
 * @subpackage functions
 */

/**
 * required setup
 */
require_once( '../bit_setup_inc.php' );

require_once( FISHEYE_PKG_PATH.'FisheyeGallery.php');
require_once( FISHEYE_PKG_PATH.'FisheyeImage.php');

global $gBitSystem, $gDebug;

$gBitSystem->verifyPermission( 'bit_p_view_fisheye' );

if( !empty( $_REQUEST['size'] ) ) {
	setcookie( 'fisheyeviewsize', $_REQUEST['size'], 0, $gBitSystem->getPreference('cookie_path'), $gBitSystem->getPreference('cookie_domain') );
}

if( !empty( $_REQUEST['refresh'] ) ) {
	$gBitSmarty->assign( 'refresh', '?refresh='.time() );
}

include_once( FISHEYE_PKG_PATH.'image_lookup_inc.php' );

global $gHideModules;
$gHideModules = $gBitSystem->isFeatureActive( 'fisheye_image_hide_modules' );

require_once( FISHEYE_PKG_PATH.'display_fisheye_image_inc.php' );

?>
