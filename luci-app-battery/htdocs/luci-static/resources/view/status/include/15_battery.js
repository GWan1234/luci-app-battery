'use strict';
'require baseclass';
'require rpc';

var callBatteryStatus = rpc.declare({
	object: 'luci.battery',
	method: 'status',
	expect: { '': {} }
});

return baseclass.extend({
	title: _('Battery'),

	load: function () {
		return callBatteryStatus();
	},

	render: function (data) {
		if (!data)
			return E('div', {}, _('No battery data available'));

		var table = E('table', { 'class': 'table' });
		var chargeTxt = (data.charging) ? _('Charging') : _('Discharging');
		var chargeClass = (data.charging) ? 'label label-success' : 'label label-warning';
		var cap = parseInt(data.capacity) || 0;

		table.appendChild(E('tr', { 'class': 'tr' }, [
			E('td', { 'class': 'td left' }, _('Battery charge')),
			E('td', { 'class': 'td right' }, [
				E('div', { 'class': 'cbi-progressbar' }, [
					E('div', { 'class': 'cbi-progressbar-inner', 'style': 'width:' + String(cap) + '%' })
				]),
				E('span', {}, String(cap) + '%')
			])
		]));
		table.appendChild(E('tr', { 'class': 'tr' }, [
			E('td', { 'class': 'td left' }, _('Status')),
			E('td', { 'class': 'td right' }, [ E('span', { 'class': chargeClass }, chargeTxt) ])
		]));

		return table;
	}
});
