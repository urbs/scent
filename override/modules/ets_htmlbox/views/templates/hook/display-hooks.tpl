<div class="col-10">
    {if isset($hooks) && sizeof($hooks) > 0}
        {foreach $hooks as $hook}
            <style>
                {$hook.style nofilter}
            </style>
            {$hook.html nofilter}
        {/foreach}
    {/if}
</div>
