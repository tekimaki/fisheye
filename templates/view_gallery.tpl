{strip}
{include file="bitpackage:fisheye/gallery_nav.tpl"}

<div class="listing fisheye">
	<div class="header">
		<div class="floaticon">
			{include file="bitpackage:liberty/services_inc.tpl" serviceLocation='icon'}
			{if $gContent->hasUserPermission( 'bit_p_edit_fisheye' )}
				<a title="{tr}Edit{/tr}" href="{$smarty.const.FISHEYE_PKG_URL}edit.php?gallery_id={$gContent->mGalleryId}">{biticon ipackage=liberty iname="config" iexplain="Edit"}</a>
				<a title="{tr}Image Order{/tr}" href="{$smarty.const.FISHEYE_PKG_URL}image_order.php?gallery_id={$gContent->mGalleryId}">{biticon ipackage=fisheye iname="order" iexplain="Image Order"}</a>
			{/if}
			{if $gContent->hasUserPermission( 'bit_p_upload_fisheye' )}
				<a title="{tr}Add Image{/tr}" href="{$smarty.const.FISHEYE_PKG_URL}upload.php?gallery_id={$gContent->mGalleryId}">{biticon ipackage=liberty iname="upload" iexplain="Add Image"}</a>
			{/if}
			{if $gContent->hasUserPermission( 'bit_p_admin_fisheye' )}
				<a title="{tr}User Permissions{/tr}" href="{$smarty.const.FISHEYE_PKG_URL}edit.php?gallery_id={$gContent->mGalleryId}&amp;delete=1">{biticon ipackage=liberty iname="delete" iexplain="Delete Gallery"}</a>
			{* appears broken at the moment	<a title="{tr}User Permissions{/tr}" href="{$smarty.const.FISHEYE_PKG_URL}edit_gallery_perms.php?gallery_id={$gContent->mGalleryId}">{biticon ipackage=liberty iname="permissions" iexplain="User Permissions"}</a> *}
			{/if}
		</div>

		<h1>{$gContent->mInfo.title}</h1>

		{if $gContent->mInfo.data}
			<p>{$gContent->mInfo.data}</p>
		{/if}
	</div>

	<div class="body">
		{formfeedback success=$fisheyeSuccess error=$fisheyeErrors warning=$fisheyeWarnings}
		{if $gBitSystem->mPrefs.fisheye_gallery_div_layout eq 'y'}
			<div class="thumbnailblock">
				{section name=ix loop=$gContent->mItems}
					{box class="box `$gContent->mInfo.thumbnail_size`-thmb `$gContent->mItems[ix]->mInfo.content_type_guid`"}
						<a href="{$gContent->mItems[ix]->getDisplayUrl()|escape}">
							<img class="thumb" src="{$gContent->mItems[ix]->getThumbnailUrl()}" alt="{$gContent->mItems[ix]->mInfo.title|default:'image'}" />
						</a>
						{if $gBitSystem->isFeatureActive( 'fisheye_gallery_list_image_titles' )}
							<h3>{$gContent->mItems[ix]->mInfo.title}</h3>
						{/if}
						{if $gBitSystem->isFeatureActive( 'fisheye_gallery_list_image_descriptions' )}
							<p>{$gContent->mImages[ix]->mInfo.data}</p>
						{/if}
					{/box}
				{sectionelse}
					<div class="norecords">{tr}This gallery is empty{/tr}. <a href="{$smarty.const.FISHEYE_PKG_URL}upload.php?gallery_id={$gContent->mGalleryId}">Upload pictures!</a></div>
				{/section}
			</div>
			<div class="clear"></div>
		{else}
			<table class="thumbnailblock">
				{counter assign="imageCount" start="0" print=false}
				{assign var="max" value=100}
				{assign var="tdWidth" value="`$max/$cols_per_page`"}
				{section name=ix loop=$gContent->mItems}
					{if $imageCount % $cols_per_page == 0}
						<tr > <!-- Begin Image Row -->
					{/if}

					<td style="width:{$tdWidth}%; vertical-align:top;"> <!-- Begin Image Cell -->
						{box class="box `$gContent->mItems[ix]->mInfo.content_type_guid`"}
							<a href="{$gContent->mItems[ix]->getDisplayUrl()|escape}">
								<img class="thumb" src="{$gContent->mItems[ix]->getThumbnailUrl()}" alt="{$gContent->mItems[ix]->mInfo.title|default:'image'}" />
							</a>
							{if $gBitSystem->isFeatureActive( 'fisheye_gallery_list_image_titles' )}
								<h2>{$gContent->mItems[ix]->mInfo.title}</h2>
							{/if}
							{if $gBitSystem->isFeatureActive( 'fisheye_gallery_list_image_descriptions' )}
								<p>{$gContent->mImages[ix]->mInfo.data}</p>
							{/if}
						{/box}
					</td> <!-- End Image Cell -->
					{counter}

					{if $imageCount % $cols_per_page == 0}
						</tr> <!-- End Image Row -->
					{/if}

				{sectionelse}
					<tr><td class="norecords">{tr}This gallery is empty{/tr}. <a href="{$smarty.const.FISHEYE_PKG_URL}upload.php?gallery_id={$gContent->mGalleryId}">Upload pictures!</a></td></tr>
				{/section}

				{if $imageCount % $cols_per_page != 0}</tr>{/if}
			</table>
		{/if}
	</div>	<!-- end .body -->

	{libertypagination numPages=$gContent->mInfo.num_pages gallery_id=$gContent->mGalleryId gallery_path=$gContent->mGalleryPath page=$pageCount}

	{include file="bitpackage:liberty/services_inc.tpl" serviceLocation='view'}

</div>	<!-- end .fisheye -->

{/strip}
