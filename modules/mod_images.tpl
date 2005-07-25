{* $Header: /cvsroot/bitweaver/_bit_fisheye/modules/mod_images.tpl,v 1.3 2005/07/25 20:02:05 squareing Exp $ *}
{strip}
{if $gBitSystem->isPackageActive( 'fisheye' ) && $modImages}
	{bitmodule title="$moduleTitle" name="fisheye_images"}
		<ul class="data">
			{foreach from=$modImages item=modImg}
				<li class="{cycle values='odd,even'} item">
					<a href="{$modImg.display_url}" title="{$modImg.title} - {$modImg.last_modified|bit_short_datetime}, by {displayname user=$modImg.modifier_user real_name=$modImg.modifier_real_name nolink=1}{if (strlen($modImg.title) > $maxlen) AND ($maxlen > 0)}, {$modImg.title}{/if}">
						<img src="{$modImg.thumbnail_url}" title="{$modImg.title}" alt="{$modImg.title}" />

						{if !$modImg.has_machine_name}
							<br />
							{if $maxlen gt 0}
								{$modImg.title|truncate:$maxlen:"...":true}
							{else}
								{$modImg.title}
							{/if}
						{/if}
					</a>

					{if $module_params.description}
						<br />
						{if $maxlendesc gt 0}
							{$modImg.data|truncate:$maxlendesc:"...":true}
						{else}
							{$modImg.data}
						{/if}
					{/if}
				</li>
			{foreachelse}
				<li></li>
			{/foreach}
		</ul>
		{if $userGallery}
		<a href="{$smarty.const.FISHEYE_PKG_URL}index.php?user_id={$userGallery}">{tr}See more...{/tr}</a>
		{/if}
	{/bitmodule}
{/if}
{/strip}
