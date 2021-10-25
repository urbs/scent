{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
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
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{extends file='layouts/layout-both-columns.tpl'}

{block name='right_column'}{/block}


{block name='content_wrapper'}
  <div id="content-wrapper" class="{block name='contentWrapperClass'}left-column col-12 col-lg-8{/block}">
    {hook h="displayContentWrapperTop"}
    {block name='content'}
      <p>Hello world! This is HTML5 Boilerplate.</p>
    {/block}
    {hook h="displayContentWrapperBottom"}
  </div>
  <div id="content-wrapper" class="{block name='contentWrapperClass'}left-column col-12 col-lg-2{/block}">
    <div class="spacer-sm"></div>
    <div id="right-calendrier">
      <div class="calendrier-boutons-top">
          <div class="calendrier-selection">
              <div id="cal_home" style="display: block;" >
                  <div class="top_calendrier tc_left"></div>
                  <div class="top_calendrier tc_right"></div>
                  <p>
                      <a href="http://localhost/content/1-livraison">
                      <strong>75001</strong><br>
                      Livraison possible à&nbsp;partir&nbsp;de<br>
                      <strong class="show-low-height">Vendredi 01/10/2021 07H00-08H00</strong>
                      </a>
                  </p>
              </div>
          </div>
          <div class="c">
              <div>
                  <a href="http://localhost/content/1-livraison" title="Voir les frais de livraison" onclick="sendEventGA( 'layer', 'ouverture', 'FL');" class="btn normal jaune">
                      <span class="fas fa-truck"></span> Les frais de livraison
                  </a>
              </div>
              <div class="spacer-sm"></div>
          </div>    
      </div>
    </div>
    <div id="right-panier">
      <div id="td_panier">
          <div class="right-panier-title" id="lib_titre_panier">
              <img alt src="img/logo_pannier.png"> Mon <strong>panier</strong>
          </div>
          <div class="bloc_panier" id="div_ligne_articles" style="padding: 0px; height: 0px;">
              <ul aria-labelledby="lib_titre_panier"></ul>  
          </div>
          <div id="div_bloc_bas" class="bloc_panier">
              <div style="text-align: center; margin: 0 auto;">
                  
                      {block name='cart_summary_products'}
                      <div class="cart-summary-products">

                          <p class="mb-0">{$cart.summary_string}</p>

                          <p>
                          <a class="link__showsummary" href="#" data-toggle="collapse" data-target="#cart-summary-product-list">
                              <span class="small">{l s='show details' d='Shop.Theme.Actions'} </span><i class="material-icons">expand_more</i>

                          </a>
                          </p>


                          {block name='cart_summary_product_list'}
                          <div class="collapse" id="cart-summary-product-list">
                              <ul class="media-list">
                              {foreach from=$cart.products item=product}
                                  <li class="media media-list__item">{include file='checkout/_partials/cart-summary-product-line.tpl' product=$product}</li>
                              {/foreach}
                              </ul>
                          </div>
                          {/block}
                      </div>
                      {/block}

                      {block name='cart_summary_subtotals'}
                          {include file='checkout/_partials/cart-summary-subtotals.tpl' cart=$cart}
                      {/block}
                      {block name='cart_summary_voucher'}
                          {include file='checkout/_partials/cart-voucher.tpl'}
                      {/block}
                  <a href="http://localhost/panier?action=show" class="btn normal rouge" title="Passer commande" rel="nofollow">Commander</a>
              </div>
          </div>
      </div>
  </div>
  </div>
{/block}

