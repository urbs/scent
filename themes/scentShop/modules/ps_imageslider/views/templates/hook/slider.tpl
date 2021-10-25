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
 
 {* urbain 2021.10.05*}
 <div class="row">
    <div class="col-12 col-lg-2 visible-md visible-lg clientbar">
        <div role="navigation" class="navigation-left">
  
                    <div style="margin-bottom: 5px;"
                        <a href="http://localhost/content/1-livraison">
                            <img alt src="img/Vignette_Home.jpg" class="img-responsive" width="185" height="50"> 
                        </a>
                    </div>
                    <div class="avis_client_container">
                        <div class="avis_client">
                            <img src="img/picto-avis-clients.png" alt="Avis clients" width="48" height="61">
                            <div>
                                <div class="etoiles"><div class="etoiles" style="background-position: 0 -16px;width: 71px;"></div></div><br>
                                <a href="#" title="Note de 4,38/5">
                                    <strong>4,38&nbsp;/&nbsp;5,00</strong>
                                </a>
                                <br>
                                <a href="#" class="link_avis">
                                    3329 avis
                                </a>
                            </div> 
                        </div>
                        <a class="btn small jaune" href="#">Donner mon avis</a>
                    </div>
                    <div class="spacer-md"></div>
                    <a href="http://localhost/content/1-livraison">
                        <img alt src="img/home_picto_bons_plans_frais_de_livraison.jpg" class="img-responsive" width="185" height="239"> 
                    </a>


            <div class="spacer-md"></div>
        </div>
    </div>
    <div class="col-12 col-lg-8">
        {if $homeslider.slides}
            {assign var=paddingbottom value=($homeslider.slides[0]['sizes'][1]/$homeslider.slides[0]['sizes'][0]*100)}
            <div id="carousel" class="carousel slick__arrow-large" {if $homeslider.slides|count > 1}data-slick={strip}
            '{literal}{
        "autoplay": true,
        "slidesToShow": 1,
        "autoplaySpeed":{/literal}{$homeslider.speed}{literal}
        }{/literal}'{/strip}{/if}>
                {foreach from=$homeslider.slides item=slide name='homeslider'}
                    <a href="{$slide.url}">
                        <div class="rc" style="padding-top:{$paddingbottom}%">
                        <img data-src="{$slide.image_url}" alt="{$slide.legend|escape}" class="w-100 lazyload img-carousel">
                        <noscript>
                            <img src="{$slide.image_url}" alt="{$slide.legend|escape}">
                        </noscript>
                        {if $slide.title || $slide.description}
                            <div class="slider-caption">
                                <p class="display-1 text-uppercase">{$slide.title}</p>
                                <div class="caption-description">{$slide.description nofilter}</div>
                            </div>
                        {/if}
                        </div>
                    </a>
                {/foreach}
            </div>
        {/if}
        <div id="bigPictoNav" class="table-responsive">
            <ul>
                <li style="background: rgba(255, 255, 255, 0.6);">
                    <button data-id="0">FOIRE aux VINS d'EXCEPTION</button>
                </li>
                <li style="background: rgba(255, 255, 255, 0.6);">
                    <button data-id="1">OFFRE GRAND MARCHE : Raisin blanc Italia</button>
                </li>
                <li style="background: rgba(255, 255, 255, 0.6);">
                    <button data-id="2">Capsules NESCAFÉ® Farmers Origins</button>
                </li>
                <li style="background: rgb(255, 255, 255);">
                    <button data-id="3">Les produits BIO</button>
                </li>
            </ul>
        </div>
    </div>
    <div class="col-12 col-lg-2" id="rightbar">
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
</div>
