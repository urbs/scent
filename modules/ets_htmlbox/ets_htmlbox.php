<?php
/**
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
 * needs please contact us for extra customization service at an affordable price
 *
 * @author ETS-Soft <etssoft.jsc@gmail.com>
 * @copyright  2007-2021 ETS-Soft
 * @license    Valid for 1 website (or project) for each purchase of license
 *  International Registered Trademark & Property of ETS-Soft
 */

if (!defined('_PS_VERSION_')) {
    exit;
}
require_once(dirname(__FILE__) . '/classes/HBHtmlbox.php');
require_once(dirname(__FILE__) . '/classes/HBHtmlboxPosition.php');

class Ets_htmlbox extends Module
{
    protected $config_form = false;

    public function __construct()
    {
        $this->name = 'ets_htmlbox';
        $this->tab = 'administration';
        $this->version = '1.0.1';
        $this->author = 'ETS - Soft';
        $this->need_instance = 0;
        /**
         * Set $this->bootstrap to true if your module is compliant with bootstrap (PrestaShop 1.6)
         */
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('HTML Box');
        $this->description = $this->l('Create, display and highlight content wherever you want on your PrestaShop store, depending on the purpose of use to emphasize or attract customers');
$this->refs = 'https://prestahero.com/';
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
    }

    public function install()
    {
        include(dirname(__FILE__) . '/sql/install.php');
        return parent::install() &&
            $this->_registerHook() &&
            $this->registerHook('header') &&
            $this->registerHook('displayHeader') &&
            $this->registerHook('backOfficeHeader') &&
            $this->registerHook('displayBackOfficeHeader') &&
            $this->registerHook('actionOutputHTMLBefore') &&
            $this->_addTab();
    }

    public function uninstall()
    {
        include(dirname(__FILE__) . '/sql/uninstall.php');
        return parent::uninstall() &&
            $this->_removeHook() &&
            $this->unregisterHook('header') &&
            $this->unregisterHook('displayHeader') &&
            $this->unregisterHook('backOfficeHeader') &&
            $this->unregisterHook('displayBackOfficeHeader') &&
            $this->unregisterHook('actionOutputHTMLBefore') &&
            $this->_removeTab();
    }

    public function _registerHook()
    {
        $hooks = HBHtmlbox::getHookPosition();
        if (sizeof($hooks) > 0) {
            foreach ($hooks as $hook) {
                $this->registerHook($hook['hook']);
            }
        }
        return true;
    }

    public function _removeHook()
    {
        $hooks = HBHtmlbox::getHookPosition();
        if (sizeof($hooks) > 0) {
            foreach ($hooks as $hook) {
                $this->unregisterHook($hook['hook']);
            }
        }
        return true;
    }

    public function _addTab()
    {
        $t = new Tab();
        $t->active = 1;
        $t->class_name = 'AdminEtsHB';
        $t->name = array();
        foreach (Language::getLanguages(true) as $lang) {
            $t->name[$lang['id_lang']] = 'HTML Box';
        }
        $t->id_parent = 0;
        $t->module = $this->name;
        if ($t->add()) {
            $t2 = new Tab();
            $t2->active = 1;
            $t2->class_name = 'AdminEtsHBBase';
            $t2->name = array();
            foreach (Language::getLanguages(true) as $lang) {
                $t2->name[$lang['id_lang']] = 'List HTML Box';
            }
            $t2->id_parent = $t->id;
            $t2->module = $this->name;
            $t2->add();
        }
        return true;
    }

    public function _removeTab()
    {
        while ($tabId = (int)Tab::getIdFromClassName("AdminEtsHB")) {
            if (!$tabId) {
                return true;
            }
            $tab = new Tab($tabId);

            if ($tab->delete()) {
                $tabId2 = (int)Tab::getIdFromClassName("AdminEtsHBBase");
                if (!$tabId2) {
                    return true;
                }
                $tab2 = new Tab($tabId2);
                $tab2->delete();
            }
        }
        return true;
    }

    public function getAdminModuleLink()
    {
        return $this->context->link->getAdminLink('AdminEtsHBBase', true);
//        return $this->context->link->getAdminLink('AdminModules', true) . '&configure=' . $this->name;
    }

    public function getContent()
    {
        Tools::redirectAdmin($this->context->link->getAdminLink('AdminEtsHBBase', true));
    }

    public function displayHooks($hook_name)
    {
        $hooks = HBHtmlbox::getHTMLBoxByHook($hook_name, Context::getContext()->language->id);
        $this->smarty->assign(array(
            'hooks' => $hooks,
        ));
        return $this->display(__FILE__, 'display-hooks.tpl');
    }

    public function doShortCode($str)
    {
        return preg_replace_callback('~\[html\-box id="(\d+)"\]~', array($this, 'replace'), $str);
    }

    public function replace($matches)
    {
        if (is_array($matches) && count($matches) == 2) {
            if ($matches[1]) {
                $hb = HBHtmlbox::getHTMLBoxById($matches[1], $this->context->language->id);
                $this->smarty->assign(array(
                    'hooks' => array(0=>$hb[0]),
                ));
                return $this->display(__FILE__, 'display-hooks.tpl');
            }
        }
    }

    public function hookActionOutputHTMLBefore($params)
    {
        if (isset($params['html']) && $params['html']) {
            $params['html'] = $this->doShortCode($params['html']);
        }
    }

    public function _backHeader()
    {
        if (
            (string)Tools::getValue('module_name') == $this->name ||
            (string)Tools::getValue('configure') == $this->name ||
            (string)Tools::getValue('controller') == 'AdminEtsHBBase'
        ) {
            $this->context->controller->setMedia();
            $this->context->controller->addJS($this->_path . 'views/js/back.js');
            $this->context->controller->addCSS($this->_path . 'views/css/back.css');
        }
        $this->context->controller->addCSS($this->_path . 'views/css/admin_all.css');

    }

    public function hookBackOfficeHeader()
    {
        $this->_backHeader();
    }

    public function hookDisplayBackOfficeHeader()
    {
        $this->_backHeader();
    }

    public function _header()
    {
        if ($this->context->controller->php_self == 'category') {
            $this->smarty->assign(array(
                'hookDisplayProductListHeaderAfter' => $this->hookDisplayProductListHeaderAfter(),
                'hookDisplayProductListHeaderBefore' => $this->hookDisplayProductListHeaderBefore(),
            ));
        }
        if ($this->context->controller->php_self == 'product') {
            $this->smarty->assign(array(
                'hookDisplayProductVariantsBefore' => $this->hookDisplayProductVariantsBefore(),
                'hookDisplayProductVariantsAfter' => $this->hookDisplayProductVariantsAfter(),
                'hookDisplayProductCommentsListHeaderBefore' => $this->hookDisplayProductCommentsListHeaderBefore(),
            ));
        }
        if ($this->context->controller->php_self == 'cart') {
            $this->smarty->assign(array(
                'hookDisplayCartGridBodyBefore1' => $this->hookDisplayCartGridBodyBefore1(),
            ));
        }
        if ($this->context->controller->php_self == 'order') {
            $this->smarty->assign(array(
                'hookDisplayCartGridBodyBefore1' => $this->hookDisplayCartGridBodyBefore1(),
                'hookDisplayCartGridBodyBefore2' => $this->hookDisplayCartGridBodyBefore2(),
                'hookDisplayCartGridBodyAfter' => $this->hookDisplayCartGridBodyAfter(),
            ));
        }
        $this->smarty->assign(array(
            'hookDisplayLeftColumnBefore' => $this->hookDisplayLeftColumnBefore(),
            'hookDisplayRightColumnBefore' => $this->hookDisplayRightColumnBefore(),
        ));
        $this->context->controller->addJS($this->_path . 'views/js/front.js');
        $this->context->controller->addCSS($this->_path . 'views/css/front.css');
        return $this->display(__FILE__, 'render-js.tpl');
    }

    public function hookHeader()
    {
        return $this->_header();
    }

    public function hookDisplayHeader()
    {
        return $this->_header();
    }

    public function hookDisplayCartGridBodyAfter()
    {
        return $this->displayHooks('displayCartGridBodyAfter');
    }

    public function hookDisplayCartGridBodyBefore1()
    {
        return $this->displayHooks('displayCartGridBodyBefore1');
    }

    public function hookDisplayCartGridBodyBefore2()
    {
        return $this->displayHooks('displayCartGridBodyBefore2');
    }

    public function hookDisplayProductCommentsListHeaderBefore()
    {
        return $this->displayHooks('displayProductCommentsListHeaderBefore');
    }

    public function hookDisplayProductVariantsBefore()
    {
        return $this->displayHooks('displayProductVariantsBefore');
    }

    public function hookDisplayProductVariantsAfter()
    {
        return $this->displayHooks('displayProductVariantsAfter');
    }

    public function hookDisplayLeftColumnBefore()
    {
        return $this->displayHooks('displayLeftColumnBefore');
    }

    public function hookDisplayRightColumnBefore()
    {
        return $this->displayHooks('displayRightColumnBefore');
    }

    public function hookDisplayProductListHeaderBefore()
    {
        return $this->displayHooks('displayProductListHeaderBefore');
    }

    public function hookDisplayProductListHeaderAfter()
    {
        return $this->displayHooks('displayProductListHeaderAfter');
    }

    public function hookDisplayNav1()
    {
        return $this->displayHooks('displayNav1');
    }

    public function hookDisplayBanner()
    {
        return $this->displayHooks('displayBanner');
    }

    public function hookDisplayHome()
    {
        return $this->displayHooks('displayHome');
    }

    public function hookDisplayFooterBefore()
    {
        return $this->displayHooks('displayFooterBefore');
    }

    public function hookDisplayFooterAfter()
    {
        return $this->displayHooks('displayFooterAfter');
    }

    public function hookDisplayFooterCategory()
    {
        return $this->displayHooks('displayFooterCategory');
    }

    public function hookDisplayShoppingCartFooter()
    {
        return $this->displayHooks('displayShoppingCartFooter');
    }

    public function hookDisplayLeftColumn()
    {
        return $this->displayHooks('displayLeftColumn');
    }

    public function hookDisplayRightColumn()
    {
        return $this->displayHooks('displayRightColumn');
    }

    public function hookDisplayAfterProductThumbs()
    {
        return $this->displayHooks('displayAfterProductThumbs');
    }

    public function hookDisplayProductActions()
    {
        return $this->displayHooks('displayProductActions');
    }

    public function hookDisplayReassurance()
    {
        return $this->displayHooks('displayReassurance');
    }

    public function hookDisplayFooterProduct()
    {
        return $this->displayHooks('displayFooterProduct');
    }

    public function hookDisplayProductListReviews()
    {
        if ($this->context->controller->php_self == 'product') {
            return $this->displayHooks('displayProductListReviews');
        }
    }
}
