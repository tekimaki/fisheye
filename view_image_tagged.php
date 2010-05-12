<?php
/**
 * @version $Header: /cvsroot/bitweaver/_bit_fisheye/Attic/view_image_tagged.php,v 1.1 2010/05/12 21:45:00 lsces Exp $
 * @package fisheye
 * @subpackage functions
 */

/**
 * required setup
 */
require_once( '../kernel/setup_inc.php' );

require_once( FISHEYE_PKG_PATH.'FisheyeGallery.php');
require_once( FISHEYE_PKG_PATH.'FisheyeImage.php');
//vd($_REQUEST);
global $gBitSystem, $gDebug;

if( !empty( $_REQUEST['size'] ) ) {
	// nuke old values if set
	$_COOKIE['fisheyeviewsize'] = NULL;
	setcookie( 'fisheyeviewsize', $_REQUEST['size'], 0, $gBitSystem->getConfig( 'cookie_path', BIT_ROOT_URL ), $gBitSystem->getConfig( 'cookie_domain', '.'.$_SERVER['SERVER_NAME'] ) );
}

if( !empty( $_REQUEST['mode'] ) ) {
	if ( $_REQUEST['save'] == 'yes' ) {
		// save tag record
	} 
	$gBitSmarty->assign( 'mode', $_REQUEST['mode'] );
}

if( !empty( $_REQUEST['delete'] ) ) {
	// delete tag record 
}

include_once( FISHEYE_PKG_PATH.'image_lookup_inc.php' );
$gContent->mInfo['tags'] = 0;
//vd($gContent);
global $gHideModules;
$gHideModules = $gBitSystem->isFeatureActive( 'fisheye_image_hide_modules' );

if( is_object( $gGallery ) && $gGallery->isCommentable() ) {
	$commentsParentId = $gContent->mContentId;
	$comments_vars = Array('fisheyeimage');
	$comments_prefix_var='fisheyeimage:';
	$comments_object_var='fisheyeimage';
	$comments_return_url = $_SERVER['PHP_SELF']."?image_id=".$gContent->mImageId;
	include_once( LIBERTY_PKG_PATH.'comments_inc.php' );
}

$gContent->addHit();

$gBitThemes->loadCss( UTIL_PKG_PATH.'/javascript/libs/jquery/themes/base/ui.all.css', TRUE );
$gBitThemes->loadAjax( 'jquery' );
$gBitThemes->loadJavascript( UTIL_PKG_PATH.'/javascript/libs/jquery/packed/ui/jquery.ui.all.packed.js', FALSE, 500, FALSE );

// this will let LibertyMime know that we want to display the original image
$gContent->mInfo['image_file']['original'] = TRUE;

if( !$gContent->isValid() ) {
	$gBitSystem->setHttpStatus( 404 );
	$gBitSystem->fatalError( tra( "No image exists with the given ID" ) ,'error.tpl', '' );
}

$displayHash = array( 'perm_name' => 'p_fisheye_view' );
$gContent->invokeServices( 'content_display_function', $displayHash );

// Get the proper thumbnail size to display on this page
if( empty( $_REQUEST['size'] )) {
	$_REQUEST['size'] = 'original';
}

$gBitSystem->setBrowserTitle( $gContent->getTitle() );
$gBitSystem->display( 'bitpackage:fisheye/view_image_tagged.tpl' , NULL, array( 'display_mode' => 'display' ));?>