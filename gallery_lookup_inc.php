<?php
/**
 * @version $Header$
 * @package fisheye
 * @subpackage functions
 */

global $gContent;

$lookup = array();

if( !$gContent = FisheyeGallery::lookup( $_REQUEST ) ) {
	$gContent = new FisheyeGallery();
	$galleryId = NULL;
}

if( !empty( $_REQUEST['gallery_path'] ) ) {
	$gContent->setGalleryPath( $_REQUEST['gallery_path'] );
} elseif( $gContent->isValid() && $parents = $gContent->getParentGalleries() ) {
	$gal = current( $parents );
	$gContent->setGalleryPath( '/'.$gal['gallery_id'] );
}

$gBitSmarty->assign_by_ref('gContent', $gContent);
$gBitSmarty->assign_by_ref('galleryId', $gContent->mGalleryId);

?>
