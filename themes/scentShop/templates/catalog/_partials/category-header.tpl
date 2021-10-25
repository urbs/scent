{*modif urbain 2021.10.20*}
<div class="block-category card-block visible--desktop">
    <div id="_desktop_category_header">
        <strong>{$category.name}{if isset($smarty.get.page) && $smarty.get.page > 1} <span class="small"> - Page {$smarty.get.page}</span>{/if}</strong>
    </div>
    {if ($category.description || $category.image.large.url) && $listing.pagination.items_shown_from == 1}
        <div class="d-flex">
            {if $category.description}
                <div id="category-description" class="text-muted">{$category.description nofilter}</div>
            {/if}
            {if $category.image.large.url}
                <div class="category-cover">
                    <img src="{$category.image.large.url}" class="lazyload" alt="{if !empty($category.image.legend)}{$category.image.legend}{else}{$category.name}{/if}">
                </div>
            {/if}
        </div>
    {/if}
</div>
<div class="_mobile_category_header"></div>
