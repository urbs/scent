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

class AdminEtsHBBaseController extends ModuleAdminController
{
    public $list_hook;
    public $errors;

    public function __construct()
    {
        $this->table = 'ets_hb_html_box';
        $this->list_id = $this->table;
        $this->lang = true;
        $this->bootstrap = true;
        $this->className = 'HBHtmlbox';
        parent::__construct();
        $this->allow_export = true;
        $this->addRowAction('edit');
        $this->addRowAction('delete');
        $this->bulk_actions = [
            'delete' => [
                'text' => $this->l('Delete selected'),
                'confirm' => $this->l('Do you want to delete selected items?'),
                'icon' => 'icon-trash',
            ],
        ];
        $this->_select = "a.`id_ets_hb_html_box` as short_code, GROUP_CONCAT(c.position) as position";
        $this->_join = "
        JOIN `" . _DB_PREFIX_ . "ets_hb_html_box_position` c ON (c.`id_ets_hb_html_box` = a.`id_ets_hb_html_box`)
        ";

        $this->_group = " GROUP BY a.id_ets_hb_html_box";
        $this->list_hook = HBHtmlbox::getHookPosition();
        $this->fields_list = [
            'id_ets_hb_html_box' => array(
                'title' => $this->l('ID'),
                'type' => 'int',
                'align' => 'text-center',
                'class' => 'fixed-width-xs center',
                'filter_key' => 'a!id_ets_hb_html_box',
                'havingFilter' => true,
                'search' => true,
                'orderby' => true,
            ),
            'name' => array(
                'title' => $this->l('Name'),
                'type' => 'text',
                'align' => 'text-left',
                'havingFilter' => true,
                'search' => true,
                'orderby' => true,
            ),
            'short_code' => array(
                'title' => $this->l('Short code'),
                'align' => 'text-center',
                'havingFilter' => false,
                'search' => false,
                'orderby' => false,
                'callback' => 'displayShortCode',
                'remove_onclick' => true
            ),
            'position' => array(
                'title' => $this->l('Position'),
                'align' => 'text-left',
                'havingFilter' => true,
                'search' => true,
                'orderby' => false,
                'type' => 'select',
                'filter_key' => 'c!position',
                'list' => HBHtmlbox::getHookFilter(),
                'callback' => 'displayHooks'
            ),
            'active' => array(
                'title' => $this->l('Enable'),
                'align' => 'text-center',
                'active' => 'status',
                'havingFilter' => true,
                'search' => true,
                'orderby' => true,
                'type' => 'select',
                'filter_key' => 'a!active',
                'list' => array(
                    '0' => 'Disable',
                    '1' => 'Active'
                ),
            ),
        ];

        $this->_defaultOrderBy = 'id_ets_hb_html_box';
        $this->_defaultOrderWay = 'DESC';
        if(!Tools::isSubmit('updateets_hb_html_box')) {
            $this->fields_value = array(
                'active' => true,
            );
        }
        $this->fields_form = array(
            'legend' => array(
                'title' => Tools::isSubmit('updateets_hb_html_box') ? $this->l('Edit HTML box') : $this->l('Add HTML box'),
                'icon' => Tools::isSubmit('updateets_hb_html_box') ? 'icon-edit' : 'icon-plus',
            ),
            'submit' => array(
                'title' => $this->l('Save'),
            ),
            'cancel' => array(
                'links' => Module::getInstanceByName('ets_htmlbox')->getAdminModuleLink()
            ),
            'input' => array(
                'id_ets_hb_html_box' => array(
                    'name' => 'id_ets_hb_html_box',
                    'type' => 'int',
                    'title' => $this->l('ID'),
                ),
                'name' => array(
                    'name' => 'name',
                    'type' => 'text',
                    'label' => $this->l('Name'),
                    'lang' => false,
                    'required' => true
                ),
                'html' => array(
                    'name' => 'html',
                    'type' => 'textarea',
                    'label' => $this->l('HTML'),
                    'lang' => true,
                    'required' => true
                ),
                'style' => array(
                    'name' => 'style',
                    'type' => 'textarea',
                    'label' => $this->l('CSS'),
                    'lang' => false,
                    'required' => false
                ),
                'position' => array(
                    'name' => 'position',
                    'type' => 'checkbox',
                    'label' => $this->l('Position'),
                    'lang' => false,
                    'required' => false,
                    'values' => array(
                        'query' => $this->list_hook,
                        'id' => 'id',
                        'name' => 'name'
                    ),
                ),
                'active' => array(
                    'type' => 'switch',
                    'label' => $this->l('Active'),
                    'name' => 'active',
                    'default' => true,
                    'is_bool' => true,
                    'required' => false,
                    'lang' => false,
                    'values' => array(
                        array(
                            'id' => 'active_on',
                            'value' => 1,
                            'label' => $this->l('Activate')
                        ),
                        array(
                            'id' => 'active_off',
                            'value' => 0,
                            'label' => $this->l('Deactivate')
                        )
                    ),
                ),

            ),
        );
        $this->_pagination = array(5, 10, 20, 25, 50, 100);
        $this->_default_pagination = 10;
        $this->_conf[33] = $this->l('Delete HTML Box successfully!');
        $this->_conf[34] = $this->l('Add HTML Box successfully!');
        $this->_conf[35] = $this->l('Edit HTML Box successfully!');
        $this->page_header_toolbar_title = $this->module->displayName;

    }

    public function initContent()
    {
        if (strpos($this->_filterHaving, "c.`position`") != false) {
            $this->_filterHaving = str_replace("c.`position`", "(position", $this->_filterHaving);
            $this->_filterHaving = str_replace("\\", "", $this->_filterHaving);
            unset($this->toolbar_title[1]);
        }

        parent::initContent();
    }

    public function renderForm()
    {
        return parent::renderForm();
    }

    public function renderList()
    {
        return parent::renderList();
    }

    public function processAdd()
    {
        $this->errors = [];
        $this->validateRules();
        $this->_validateRules();
        if (count($this->errors) <= 0) {
            $errors = [];
            $object = new HBHtmlbox();
            parent::copyFromPost($object, $this->table);
            $object->name = (string)Tools::getValue('name');
            $object->style = (string)Tools::getValue('style');
            $object->active = (int)Tools::getValue('active');
            $i = 1;
            $html_1 = '';
            $languages = Language::getLanguages(false);
            foreach ($languages as $language) {
                $html = (string)Tools::getValue('html_' . $language['id_lang']);
                if ($html != '' || $i == 1) {
                    $object->html[$language['id_lang']] = $html;
                    $i = 0;
                } else {
                    $object->html[$language['id_lang']] = $html_1;
                }
            }
            if ($object->add()) {
                $position = (array)Tools::getValue('position');
                if (sizeof($position) > 0) {
                    foreach ($position as $p) {
                        $obj = new HBHtmlboxPosition();
                        $obj->id_ets_hb_html_box = $object->id;
                        $obj->position = (int)$p;
                        $obj->add();
                    }
                }
            }
            $this->beforeAdd($object);
            if (method_exists($this->object, 'add') && !$this->object->add()) {
                $this->errors[] = $this->l('An error occurred while creating an object.');
                $this->errors = $errors;
            }
            $this->redirect_after = self::$currentIndex . '&conf=34&token=' . $this->token;
            if (Tools::getValue('stay')) {
                Tools::redirectAdmin(self::$currentIndex . '&updateets_hb_html_box=&id_ets_hb_html_box=' . $object->id . '&conf=34&token=' . $this->token);
            }
            return $object;
        }
        $this->display = 'edit';
        return false;
    }

    public function processUpdate()
    {
        $this->errors = [];
        $id = (int)Tools::getValue('id_ets_hb_html_box');
        $object = new HBHtmlbox($id);
        $this->validateRules();
        $this->_validateRules();
        if (count($this->errors) <= 0) {
            parent::copyFromPost($object, $this->table);
            $object->name = (string)Tools::getValue('name');
            $object->style = (string)Tools::getValue('style');
            $object->active = (int)Tools::getValue('active');
            $i = 1;
            $html_1 = '';
            $languages = Language::getLanguages(false);
            foreach ($languages as $language) {
                $html = (string)Tools::getValue('html_' . $language['id_lang']);
                if ($html != '' || $i == 1) {
                    $object->html[$language['id_lang']] = $html;
                    $i = 0;
                } else {
                    $object->html[$language['id_lang']] = $html_1;
                }
            }
            $this->redirect_after = self::$currentIndex . '&conf=35&token=' . $this->token;
            $rs = $object->update();
            if ($rs) {
                HBHtmlboxPosition::deletePosition($object->id);
                $position = (array)Tools::getValue('position');
                if (sizeof($position) > 0) {
                    foreach ($position as $p) {
                        $obj = new HBHtmlboxPosition();
                        $obj->id_ets_hb_html_box = $object->id;
                        $obj->position = $p;
                        $obj->add();
                    }
                }
            }
            if (Tools::getValue('stay')) {
                Tools::redirectAdmin(self::$currentIndex . '&updateets_hb_html_box=&id_ets_hb_html_box=' . $id . '&conf=35&token=' . $this->token);
            }
            return $object;
        }
        $this->display = 'edit';
        return false;
    }

    public function _validateRules()
    {
        $errors = array();
        if (Tools::isSubmit('submitAddets_hb_html_box') || (Tools::isSubmit('submitAddets_hb_html_box') && (int)Tools::getValue('id_ets_hb_html_box'))) {
            if (!Validate::isCleanHtml(Tools::getValue('name'))) {
                $errors[] = $this->l('Name is not valid.');
            }
            if (!Tools::getValue('name')) {
                $errors[] = $this->l('Name is required.');
            }
            $languages = Language::getLanguages(false);
            $html_default = '';
            foreach ($languages as $language) {
                if ($html_default == '' && (string)Tools::getValue('html_' . (int)$language['id_lang']) != '') {
                    $html_default = (string)Tools::getValue('html_' . (int)$language['id_lang']);
                }
                if (Tools::strlen(Tools::getValue('html_' . $language['id_lang'])) < 1 && $html_default == '') {
                    $errors[] = $this->l('[' . Tools::strtoupper($language['iso_code']) . '] HTML code is required.');
                }
                if (!Validate::isString(Tools::getValue('html_' . $language['id_lang']))) {
                    $errors[] = $this->l('[' . Tools::strtoupper($language['iso_code']) . '] HTML code is not valid.');
                }
            }
            if (!Validate::isString(Tools::getValue('style'))) {
                $errors[] = $this->l('CSS is not valid.');
            }
            if (Tools::getValue('position')) {
                $arr = (array)Tools::getValue('position');
                if (!Validate::isArrayWithIds($arr)) {
                    $errors[] = $this->l('Position is invalid.');
                }
                if (sizeof($arr) == 0) {
                    $errors[] = $this->l('Position is required.');
                } else {
                    foreach ($arr as $item) {
                        if (!Validate::isInt($item)) {
                            $errors[] = $this->l('Position is invalid.');
                        }
                    }
                }
            }
            if (!Validate::isInt(Tools::getValue('active'))) {
                $errors[] = $this->l('Status must be boolean.');
            }
        }
        $this->errors = $errors;
    }

    public function displayHooks($value)
    {
        if ($value != null) {
            $arr = explode(',', $value);
        } else {
            $arr = array();
        }
        $html = '<ul class="ets-list-hook">';
        $position = HBHtmlbox::getHookPosition();
        if (sizeof($arr)) {
            if (sizeof($position)) {
                foreach ($position as $item) {
                    if (in_array($item['id'], $arr)) {
                        $html = $html . '<li>' . $item['name'] . ' <span>(' . $item['hook'] . ')</span></li>';
                    }
                }
            }
        }
        $html = $html . '</ul>';
        return $html;
    }

    public function displayShortCode($value)
    {
        $html = "<div class=\"short-code\">
                    <input title=\"" . $this->l('Click to copy') . "\" 
                           class=\"ctf-short-code\"
                           type=\"text\"
                           value=\"[html-box id=&quot;" . (int)$value . "&quot;]\">
                    <span class=\"text-copy\">" . $this->l('Copied') . "</span>
                 </div>";
        return $html;
    }
}
