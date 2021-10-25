{*
* 2007-2020 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author     PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2020 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{if $orders}
  <a href="{$link->getAdminLink('AdminColissimoAffranchissement')|escape:'htmlall':'UTF-8'}" class="btn btn-primary">
    <i class="icon icon-chevron-left"></i> {l s='Back to selection' mod='colissimo'}
  </a>
{/if}

<div id="colissimo-process" style="display: none">
  <img src="{$data.img_path|escape:'html':'UTF-8'}loading.svg"/>
</div>
<div id="colissimo-process-result"></div>

{if $orders}
  <div class="alert alert-warning colissimo-package-text">
    {l s='If you need to ship an order with multiples package, please click on' mod='colissimo'} <span class="col-reference-plus"><i class="icon icon-plus-circle"></i></span> {l s='below' mod='colissimo'}
  </div>  
  <form method="post" class="form-horizontal" id="colissimo-affranchissement-configuration">
    <div class="colissimo-configuration panel collapse in">
      <div>
        <table class="table colissimo-configuration-table">
          <thead>
          <tr>
            <th></th>
            <th><span class="title_box text-center">{l s='Reference' mod='colissimo'}</span></th>
            <th><span class="title_box text-center">{l s='ID' mod='colissimo'}</span></th>
            <th><span class="title_box text-center">{l s='Delivery address' mod='colissimo'}</span></th>
            <th><span class="title_box text-center">{l s='Service' mod='colissimo'}</span></th>
            <th><span class="title_box text-center">{l s='Include' mod='colissimo'}
                <br/>{l s='return label' mod='colissimo'}</span>
            </th>
            <th><span class="title_box text-center">{l s='Insurance' mod='colissimo'}</span></th>
            <th><span class="title_box text-center">{l s='TA' mod='colissimo'}</span></th>
            <th>
              <span class="title_box text-center">{l s='D150' mod='colissimo'}</span>
              <span class="text-muted text-center">{l s='(non machinable)' mod='colissimo'}</span>
            </th>
            <th><span class="title_box text-center">{l s='Total product Weight' mod='colissimo'}</span></th>
            {if isset($weight_tare)}
                <th><span class="title_box text-center">{l s='Tare Weight' mod='colissimo'}</span></th>
            {/if}
            <th><span class="title_box text-center">{l s='Result' mod='colissimo'}</span></th>
          </tr>
          </thead>
          <tbody>
          {foreach $orders as $key => $order}
            <tr class="row-id-order-{$order.id_order|intval}">
              <td>
                <input class="colissimo-order-selection"
                       type="checkbox"
                       checked="checked"
                       name="colissimo_order_{$key|intval}">
              </td>
              <td class="text-left pointer col-reference-plus">
                <i class="icon icon-plus-circle"></i> {$order.reference|escape:'htmlall':'UTF-8'}
              </td>
              <td class="text-center">
                {$order.id_order|intval}
              </td>
              <td class="text-left colissimo-delivery-addr">
                {include file="../_partials/td-affranchissement-delivery-address.tpl"}
              </td>
              <td class="text-center colissimo-service">
                {include file="../_partials/td-affranchissement-service.tpl"}
              </td>
              <td class="text-center colissimo-return-label">
                <input {if $order.return_label < 0}disabled="disabled"{/if}
                       type="checkbox" {if $order.return_label == 1}checked="checked"{/if}
                       name="colissimo_return_label_{$key|intval}"/>
              </td>
              <td class="text-center colissimo-insurance">
                {include file="../_partials/td-affranchissement-insurance.tpl"}
              </td>
              <td class="text-center colissimo-ta">
                {include file="../_partials/td-affranchissement-ftd.tpl"}
              </td>
              <td class="text-center colissimo-d150">
                <input {if $order.relais}disabled="disabled"{/if} type="checkbox" name="colissimo_d150_{$key|intval}"/>
              </td>
              <td class="text-center colissimo-weight">
                <div class="input-group input fixed-width-sm">
                  <input type="text"
                         onchange="this.value = this.value.replace(/,/g, '.')"
                         name="colissimo_weight_{$key|intval}"
                         value="{$order.total_weight|floatval}"
                         class="input fixed-width-sm">
                  <span class="input-group-addon">{$order.weight_unit|escape:'htmlall':'UTF-8'}</span>
                </div>
              </td>
              {if isset($weight_tare)}
                <td class="text-center colissimo-weight_tare">
                    <div class="input-group input fixed-width-sm">
                        <input type="text"
                           onchange="this.value = this.value.replace(/,/g, '.')"
                           name="colissimo_weight_tare_{$key|intval}"
                           value="{$weight_tare|floatval}"
                           class="input fixed-width-sm">
                        <span class="input-group-addon">{$order.weight_unit|escape:'htmlall':'UTF-8'}</span>
                    </div>
                </td>
              {/if}     
              <td class="text-center colissimo-order-result colissimo-order-result-{$key|intval}">
                --
              </td>
            </tr>
            {foreach $order.products as $product}
                <input type="hidden"  name="colissimo_orderBox_{$key|intval}_{$product.product_id|intval}_{$product.product_attribute_id|intval}" value="{$product.product_quantity|intval}" />
            {/foreach}
          {/foreach}
          </tbody>
        </table>
      </div>
      <button id="submit-process-colissimo-configuration"
              name="submitProcessColissimoConfiguration"
              class="btn btn-primary pull-right">
        <i class="process-icon- icon-refresh"></i> {l s='Process these shipments' mod='colissimo'}
      </button>
      <div class="clearfix"></div>
    </div>
  </form>
  <a href="{$link->getAdminLink('AdminColissimoAffranchissement')|escape:'htmlall':'UTF-8'}" class="btn btn-primary">
    <i class="icon icon-chevron-left"></i> {l s='Back to selection' mod='colissimo'}
  </a>
{else}
  <div class="alert alert-info">
    {l s='There is no shipments to process for now.' mod='colissimo'}
  </div>
{/if}

{literal}
<script type="text/javascript">
    var loaderPath = {/literal}'{$data.img_path|escape:'html':'UTF-8'}loading.svg'{literal};
    var queueingText = "{/literal}{l s='Queueing...' mod='colissimo'}{literal}";
    var noOrdersText = "{/literal}{l s='Please select at least one order.' mod='colissimo'}{literal}";
    var state_token = '{/literal}{getAdminToken tab='AdminStates'}{literal}';
    var autostartPostage = {/literal}{if isset($autostartPostage)}1{else}0{/if}{literal};
    var genericErrorMessage = "{/literal}{l s='An error occured. Please try again.' mod='colissimo'}{literal}";
    var tokenAffranchissement = '{/literal}{getAdminToken tab='AdminColissimoAffranchissement'}{literal}';
    var tokenLabel = '{/literal}{getAdminToken tab='AdminColissimoLabel'}{literal}';

    $(document).off('click').on('click', '.colissimo-service-selection', function (e) {
        e.preventDefault();

        var idOrder = $(this).attr('data-id-order');

        $(this).find('i').toggleClass('icon-spin icon-spinner');
        $(this).find('i').removeClass('icon-refresh');
        $(this).toggleClass('disabled');
        loadColissimoServiceModalUpdate(idOrder);
    });
</script>
{/literal}
