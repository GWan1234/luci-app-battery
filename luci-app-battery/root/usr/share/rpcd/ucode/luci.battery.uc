'use strict';

import * as fs from 'fs';

const BATTERY_PATH = '/sys/class/power_supply/battery';
const CHARGER_PATH = '/sys/class/power_supply/charger';

function readAttr(path) {
	let v = null;
	try {
		v = fs.readfile(path);
	} catch (e) {
		v = null;
	}
	if (v == null)
		return '';
	return v.trim();
}

return {
	status: function () {
		let capacity = readAttr(BATTERY_PATH + '/capacity') || '0';
		let status   = readAttr(BATTERY_PATH + '/status');
		let online   = readAttr(CHARGER_PATH + '/online');

		return {
			capacity: capacity,
			status: status,
			online: online,
			charging: (status == 'Charging' || status == 'Full' || online == '1')
		};
	}
};
