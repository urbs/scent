<?php
/**
 * 2007-2020 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
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
 * @author     PrestaShop SA <contact@prestashop.com>
 * @copyright  2007-2020 PrestaShop SA
 * @license    http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

/**
 * Upgrade to 1.3.1
 *
 * @param $module Colissimo
 * @return bool
 * @throws PrestaShopDatabaseException
 * @throws PrestaShopException
 */
function upgrade_module_1_3_1($module)
{
    $logsEnabled = Configuration::get('COLISSIMO_LOGS');
    Configuration::updateValue('COLISSIMO_LOGS', 1);
    $module->initLogger();
    $module->logger->setChannel('ModuleUpgrade');
    $module->logger->info('Module upgrade. Version 1.3.1');

    // Add new column in colissimo_order table if needed
    try {
        $columnExists = Db::getInstance()
                          ->executeS('SHOW COLUMNS FROM `'._DB_PREFIX_.'colissimo_order` LIKE "hidden"');
    } catch (Exception $e) {
        $module->logger->error($e->getMessage());
        Configuration::updateValue('COLISSIMO_LOGS', (int) $logsEnabled);

        return false;
    }
    if (empty($columnExists)) {
        $result = Db::getInstance()
                    ->execute('ALTER TABLE `'._DB_PREFIX_.'colissimo_order` ADD COLUMN `hidden` TINYINT(3) UNSIGNED NULL DEFAULT \'0\' AFTER `migration`;');
        if (!$result) {
            $module->logger->error('Cannot add column in colissimo_order table.');
            Configuration::updateValue('COLISSIMO_LOGS', (int) $logsEnabled);

            return false;
        }
        $module->logger->info('New column in colissimo_order created.');
    } else {
        $module->logger->info('Column hidden already exists.');
    }

    $module->logger->info('Module upgraded.');
    Configuration::updateValue('COLISSIMO_LOGS', (int) $logsEnabled);

    return true;
}
