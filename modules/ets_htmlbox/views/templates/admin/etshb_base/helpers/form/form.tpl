{*
* 2007-2021 ETS-Soft
*
* NOTICE OF LICENSE
*
* This file is not open source! Each license that you purchased is only available for 1 wesite only.
* If you want to use this file on more websites (or projects), you need to purchase additional licenses.
* You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs, please contact us for extra customization service at an affordable price
*
*  @author ETS-Soft <etssoft.jsc@gmail.com>
*  @copyright  2007-2021 ETS-Soft
*  @license    Valid for 1 website (or project) for each purchase of license
*  International Registered Trademark & Property of ETS-Soft
*}

{block name='notifications'}
    {include file='./notifications.tpl'}
{/block}
{extends file="helpers/form/form.tpl"}

{block name="field"}
    {if $input.name=='id_ets_hb_html_box' && isset($fields_value['id_ets_hb_html_box']) && $fields_value['id_ets_hb_html_box']}
        <div class="col-lg-3"></div>
        <div class="col-lg-9">
            <style>
                .alert.alert-warning {
                    background: #FFFFFF;
                    color: #00b8df !important;
                    border: 1px solid #00b8df !important;
                    border-left: 3px solid #00b8df !important;;
                }

                .alert.alert-warning:before {
                    color: #00b8df !important;
                    top: 45% !important;
                    transform: translateY(-50%) !important;
                }
            </style>
            <p class="alert alert-warning" style="max-width: 85%">
                {l s='HTML Box shortcode: ' mod='ets_htmlbox'}
                <span title="{l s='Click to copy' mod='ets_htmlbox'}"
                      style="position: relative;display: inline-block; vertical-align: middle;">
                    <input type="text" class="ctf-short-code"
                           value='[html-box id="{$fields_value['id_ets_hb_html_box']|intval}"]'/>
                    <span class="text-copy">{l s='Copied' mod='ets_htmlbox'}</span>
                </span>
                <br/>
                {l s='Copy the shortcode above, paste into anywhere on your product description, CMS page content, .tpl files, etc. in order to display this HTML Box' mod='ets_htmlbox'}
            </p>
        </div>
        {$smarty.block.parent}
    {/if}
    {if $input.type == 'checkbox'}
        <div class="col-lg-9">
            <div class="row html_column_2_col">
                {if sizeof($input.values.query) > 0}
                    {foreach $input.values.query as $position}
                        <div class="checkbox col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <label for="position_{$position.id|escape:'html':'UTF-8'}">
                                <input type="checkbox" name="position[]"
                                       id="position_{$position.id|escape:'html':'UTF-8'}" class=""
                                       value="{$position.id|escape:'html':'UTF-8'}"
                                       {if isset($fields_value.position) && is_array($fields_value.position) && in_array($position.id,$fields_value.position)}checked{/if}>
                                {$position.name|escape:'html':'UTF-8'}
                                <span>({$position.hook|escape:'html':'UTF-8'})</span>
                            </label>
                        </div>
                    {/foreach}
                {/if}
            </div>
        </div>
    {else}
        {$smarty.block.parent}
    {/if}
{/block}
{block name="footer"}
    {capture name='form_submit_btn'}{counter name='form_submit_btn'}{/capture}
    {if isset($fieldset['form']['submit']) || isset($fieldset['form']['buttons'])}
        <div class="panel-footer">
            {if isset($fieldset['form']['submit']) && !empty($fieldset['form']['submit'])}
                <button type="submit" value="1"
                        id="{if isset($fieldset['form']['submit']['id'])}{$fieldset['form']['submit']['id']}{else}{$table}_form_submit_btn{/if}{if $smarty.capture.form_submit_btn > 1}_{($smarty.capture.form_submit_btn - 1)|intval}{/if}"
                        name="{if isset($fieldset['form']['submit']['name'])}{$fieldset['form']['submit']['name']}{else}{$submit_action}{/if}{if isset($fieldset['form']['submit']['stay']) && $fieldset['form']['submit']['stay']}AndStay{/if}"
                        class="{if isset($fieldset['form']['submit']['class'])}{$fieldset['form']['submit']['class']}{else}btn btn-default pull-right{/if}">
                    <i class="{if isset($fieldset['form']['submit']['icon'])}{$fieldset['form']['submit']['icon']}{else}process-icon-save{/if}"></i> {$fieldset['form']['submit']['title']}
                </button>
                <button type="button" value="1"
                        id="_{if isset($fieldset['form']['submit']['id'])}{$fieldset['form']['submit']['id']}{else}{$table}_form_submit_btn{/if}{if $smarty.capture.form_submit_btn > 1}_{($smarty.capture.form_submit_btn - 1)|intval}{/if}"
                        name="_{if isset($fieldset['form']['submit']['name'])}{$fieldset['form']['submit']['name']}{else}{$submit_action}{/if}{if isset($fieldset['form']['submit']['stay']) && $fieldset['form']['submit']['stay']}AndStay{/if}"
                        class="{if isset($fieldset['form']['submit']['class'])}{$fieldset['form']['submit']['class']}{else}btn btn-default pull-right{/if}">
                    <i class="{if isset($fieldset['form']['submit']['icon'])}{$fieldset['form']['submit']['icon']}{else}process-icon-save{/if}"></i> {l s='Save and Stay' mod='ets_htmlbox'}
                </button>
            {/if}
            {if isset($show_cancel_button) && $show_cancel_button}
                <a class="btn btn-default" {if $table}id="{$table}_form_cancel_btn"{/if}
                   onclick="javascript:window.location.href = '{$fieldset['form']['cancel']['links']}'">
                    <i class="process-icon-cancel"></i> {l s='Cancel' d='Admin.Actions'}
                </a>
            {/if}
            {if isset($fieldset['form']['reset'])}
                <button
                        type="reset"
                        id="{if isset($fieldset['form']['reset']['id'])}{$fieldset['form']['reset']['id']}{else}{$table}_form_reset_btn{/if}"
                        class="{if isset($fieldset['form']['reset']['class'])}{$fieldset['form']['reset']['class']}{else}btn btn-default{/if}"
                >
                    {if isset($fieldset['form']['reset']['icon'])}<i
                        class="{$fieldset['form']['reset']['icon']}"></i> {/if} {$fieldset['form']['reset']['title']}
                </button>
            {/if}
            {if isset($fieldset['form']['buttons'])}
                {foreach from=$fieldset['form']['buttons'] item=btn key=k}
                    {if isset($btn.href) && trim($btn.href) != ''}
                        <a href="{$btn.href}" {if isset($btn['id'])}id="{$btn['id']}"{/if}
                           class="btn btn-default{if isset($btn['class'])} {$btn['class']}{/if}" {if isset($btn.js) && $btn.js} onclick="{$btn.js}"{/if}>{if isset($btn['icon'])}
                                <i class="{$btn['icon']}" ></i> {/if}{$btn.title}</a>
                    {else}
                        <button type="{if isset($btn['type'])}{$btn['type']}{else}button{/if}"
                                {if isset($btn['id'])}id="{$btn['id']}"{/if}
                               {if isset($btn['value'])}value="{$btn['value']}"{/if}
                                class="btn btn-default{if isset($btn['class'])} {$btn['class']}{/if}"
                                name="{if isset($btn['name'])}{$btn['name']}{else}submitOptions{$table}{/if}"{if isset($btn.js) && $btn.js} onclick="{$btn.js}"{/if}>{if isset($btn['icon'])}
                                <i class="{$btn['icon']}" ></i> {/if}{$btn.title}</button>
                    {/if}
                {/foreach}
            {/if}
        </div>
    {/if}
{/block}