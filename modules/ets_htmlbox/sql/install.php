<?php
/**
* 2007-2021 PrestaShop
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
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2021 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

$sql = array();

$sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'ets_hb_html_box` (
    `id_ets_hb_html_box` int(11) NOT NULL AUTO_INCREMENT,
    `id_shop` int(11) UNSIGNED NOT NULL DEFAULT 1,
    `name` varchar(50) NULL,
    `style` text NULL,
    `active` tinyint(1) NOT NULL,
    PRIMARY KEY  (`id_ets_hb_html_box`)
) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;';
$sql[] = "CREATE TABLE IF NOT EXISTS `" . _DB_PREFIX_ . "ets_hb_html_box_lang` (
        `id_ets_hb_html_box_lang` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `id_ets_hb_html_box` int(11) unsigned NOT NULL,
        `id_lang` int(10) unsigned NOT NULL,
        `html` text NOT NULL,
        PRIMARY KEY (`id_ets_hb_html_box_lang`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8";
$sql[] = "CREATE TABLE IF NOT EXISTS `" . _DB_PREFIX_ . "ets_hb_html_box_position` (
        `id_ets_hb_html_box_position` int(10) unsigned NOT NULL AUTO_INCREMENT,
        `id_ets_hb_html_box` int(11) unsigned NOT NULL,
        `position` int(11) unsigned NOT NULL,
        PRIMARY KEY (`id_ets_hb_html_box_position`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8";
foreach ($sql as $query) {
    if (Db::getInstance()->execute($query) == false) {
        return false;
    }
}
