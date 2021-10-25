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

<div class="panel product-tab">
  <div class="row">
    <div class="col-md-12">
      <p class="subtitle">{l s='Please fill in the customs information of your product' mod='colissimo'}</p>
      <div class="row">
        <div class="form-group col-md-4">
          <label class="form-control-label">{l s='Hs code' mod='colissimo'}</label>
          <input name="hs_code"
                 type="text"
                 class="form-control"
                 value="{$product_details->hs_code|escape:'html':'UTF-8'}"/>
        </div>
      </div>
      <div class="row">
        <div class="form-group col-md-4">
          <label class="form-control-label">{l s='Country origin' mod='colissimo'}</label>
          <select class="form-control" name="country_origin">
            <option value="0">{l s='-- Please select a country --' mod='colissimo'}</option>
            {foreach $countries as $country}
              <option value="{$country['id_country']|intval}"
                      {if $product_details->id_country_origin == $country['id_country']}selected{/if}>
                {$country['name']|escape:'html':'UTF-8'}
              </option>
            {/foreach}
          </select>
        </div>
      </div>
      <div class="row">
        <div class="form-group col-md-4">
          <label class="form-control-label">{l s='Short description' mod='colissimo'}</label>
          <input name="short_desc"
                 class="form-control"
                 maxLenght="64"
                 value="{$product_details->short_desc|escape:'html':'UTF-8'}"/>
        </div>
      </div>
    </div>
  </div>
  <div class="panel-footer">
    <a href="{$link->getAdminLink('AdminProducts')|escape:'html':'UTF-8'}"
       class="btn btn-default"><i class="process-icon-cancel"></i> {l s='Cancel' mod='colissimo'}</a>
    <button type="submit" name="submitAddproduct" class="btn btn-default pull-right">
      <i class="process-icon-save"></i> {l s='Save' mod='colissimo'}</button>
    <button type="submit" name="submitAddproductAndStay" class="btn btn-default pull-right">
      <i class="process-icon-save"></i> {l s='Save and stay' mod='colissimo'}</button>
  </div>
</div>
