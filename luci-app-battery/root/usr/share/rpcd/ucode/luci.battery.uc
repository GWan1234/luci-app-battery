'use strict';

import * as fs from 'fs';

const BATTERY_PATH = '/sys/class/power_supply/battery';
const CHARGER_PATH = '/sys/class/power_supply/charger';

function readAttr(path) {
	let raw = null;
	try {
		raw = fs.readfile(path);
	} catch (e) {
		raw = null;
	}
	return (raw != null) ? trim(raw) : '';
}

return {
	"luci.battery": {
		status: {
			call: function (request) {
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
		}
	}
};
