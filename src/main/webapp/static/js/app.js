/**
 **/
var baseUrl = "http://www.yaoxq.com/dailao/";
//var baseUrl = "http://localhost:8080"; 192.168.1.102 4 www.yaoxq.com 192.168.1.117

(function($, owner) {
	var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
	/**
	 * 用户登录
	 **/
	owner.login = function(loginInfo, callback) {
		callback = callback || $.noop;
		loginInfo = loginInfo || {};
		loginInfo.account = loginInfo.account || '';
		loginInfo.password = loginInfo.password || '';
		if (loginInfo.account.length < 3) {
			return callback('账号最短为 3 个字符');
		}
		if (loginInfo.password.length < 6) {
			return callback('密码最短为 6 个字符');
		}
		mui.ajax({
			type: "post",
			url: baseUrl + "login",
			data: {
				phoneNum: loginInfo.account,
				password: loginInfo.password
			},
			async: true,
			dataType: "json",
			success: function(data) {
				if (data.code == 1) {
					if (data.message.length > 0) {
						return owner.createState(data.dlUser.id, loginInfo.account, loginInfo.password, data.dlUser.name, data.message, callback);
					} else {
						return callback('服务错误');
					}
				} else {
					return callback(data.message);
				}
			},
			error: function(data) {
				return callback('服务错误！');
			}
		});

		//		var users = JSON.parse(localStorage.getItem('$users') || '[]');
		//		var authed = users.some(function(user) {
		//			return loginInfo.account == user.account && loginInfo.password == user.password;
		//		});
		//		if (authed) {
		//			return owner.createState(loginInfo.account, callback);
		//		} else {
		//			return callback('用户名或密码错误');
		//		}
	};
	/**
	 * wx用户登录
	 **/
	owner.wxlogin = function(id, name, callback) {
		mui.ajax({
			type: "post",
			url: baseUrl + "wxlogin",
			data: {
				thirdUserId: id,
				name: name
			},
			async: true,
			dataType: "json",
			success: function(data) {
				if (data.code == 1) {
					if (data.message.length > 0) {
						return owner.createState(data.dlUser.id, id, null, data.dlUser.name, data.message, callback);
					} else {
						return callback('服务错误');
					}
				} else {
					return callback(data.message);
				}
			},
			error: function(data) {
				return callback('服务错误:' + data.message);
			}
		});
	};
	/**
	 * 手机号登陆
	 **/
	owner.phoneLogin = function(regInfo, callback) {
		callback = callback || $.noop;
		regInfo = regInfo || {};
		var account = regInfo.account || '';
		if (!myreg.test(regInfo.account)) {
			return callback('手机号格式不正确!');
		}
		if (regInfo.verify.length < 1) {
			return callback('验证码不能为空');
		}
		mui.ajax({
			type: "post",
			url: baseUrl + "phoneLogin",
			data: {
				phoneNum: regInfo.account,
				verify: regInfo.verify
			},
			async: true,
			dataType: "json",
			success: function(data) {
				if (data.code == 1) {
					if (data.message.length > 0) {
						return owner.createState(data.dlUser.id, account, null, data.dlUser.name, data.message, callback);
					} else {
						return callback('服务错误');
					}
				} else {
					return callback(data.message);
				}
			},
			error: function(data) {
				return callback('服务错误:' + data.message);
			}
		});
	};
	/**
	 * 新用户注册
	 **/
	owner.reg = function(regInfo, callback) {
		callback = callback || $.noop;
		regInfo = regInfo || {};
		regInfo.account = regInfo.account || '';
		regInfo.password = regInfo.password || '';

		if (!myreg.test(regInfo.account)) {
			return callback('请输入有效的手机号码！');
		}
		if (regInfo.account.length < 3) {
			return callback('用户名最短需要 3 个字符');
		}
		if (regInfo.password.length < 6) {
			return callback('密码最短需要 6 个字符');
		}
		if (regInfo.verify.length < 1) {
			return callback('验证码不能为空');
		}
		mui.ajax({
			type: "post",
			url: baseUrl + "regist",
			data: {
				phoneNum: regInfo.account,
				password: regInfo.password,
				verify: regInfo.verify
			},
			async: true,
			dataType: "json",
			success: function(data) {
				if (data.code == 1) {
					if (data.message.length > 0) {
						return callback();
					} else {
						return callback('服务错误');
					}
				} else {
					return callback(data.message);
				}
			},
			error: function(data) {
				return callback('服务错误:' + data.message);
			}
		});
		//		var users = JSON.parse(localStorage.getItem('$users') || '[]');
		//		users.push(regInfo);
		//		localStorage.setItem('$users', JSON.stringify(users));

	};
	/**
	 * 找回密码
	 **/
	owner.forgetPassword = function(regInfo, callback) {
		callback = callback || $.noop;
		if (!myreg.test(regInfo.account)) {
			return callback('手机号格式不正确!');
		}
		if (regInfo.password.length < 6) {
			return callback('密码最短需要 6 个字符');
		}
		if (regInfo.verify.length < 1) {
			return callback('验证码不能为空');
		}
		mui.ajax({
			type: "post",
			url: baseUrl + "modifyUserPasswordByPhone",
			data: {
				phoneNum: regInfo.account,
				newPassword: regInfo.password,
				verify: regInfo.verify
			},
			async: true,
			dataType: "json",
			success: function(data) {
				if (data.code == 1) {
					if (data.message.length > 0) {
						return callback();
					} else {
						return callback('服务错误');
					}
				} else {
					return callback(data.message);
				}
			},
			error: function(data) {
				return callback('服务错误:' + data.message);
			}
		});
	};
	/**
	 * 发布订单
	 **/
	owner.release = function(releaseInfo, callback) {
		callback = callback || $.noop;
		if (releaseInfo.title.length < 1) {
			return callback('标题不能为空');
		}
		if (releaseInfo.startTime.length < 1) {
			return callback('开始时间不能为空');
		}
		if (releaseInfo.address.length < 1) {
			return callback('地点描述不能为空');
		}
		if (releaseInfo.latitude.length < 1 || releaseInfo.longitude.length < 1) {
			return callback('经纬度不能为空');
		}
		if (releaseInfo.priceType.length < 1) {
			return callback('报酬类型不能为空');
		}
		if (releaseInfo.price.length < 1) {
			return callback('报酬不能为空');
		}
		if (releaseInfo.contact.length < 1) {
			return callback('联系方式不能为空');
		}
		if (!myreg.test(releaseInfo.contact)) {
			return callback('请输入正确的联系方式');
		}
		if (releaseInfo.priceType == '1') {
			if (isNaN(releaseInfo.price) || (releaseInfo.price.split(".").length > 1 && releaseInfo.price.split(".")[1].length > 2)) {
				return callback('报酬类型不正确');
			}
			releaseInfo.priceInfo = '';
		} else {
			releaseInfo.price = 0;
		}
		if (releaseInfo.city.length < 1) {
			return callback('发布城市获取失败');
		}
		var state = JSON.parse(localStorage.getItem('$state'));
		//		alert(releaseInfo.latitude + "==" + releaseInfo.longitude);
		mui.ajax({
			type: "post",
			url: baseUrl + "orderSubmit",
			data: {
				name: state.account,
				token: state.token,
				cateName: releaseInfo.cateName,
				title: releaseInfo.title,
				otherInfo: releaseInfo.content,
				startTime: new Date(releaseInfo.startTime),
				endTime: new Date(releaseInfo.startTime),
				tradePlace: releaseInfo.address,
				offerAmount: releaseInfo.price,
				offerType: releaseInfo.priceType,
				offerInfo: releaseInfo.priceInfo,
				contactInfo: releaseInfo.contact,
				addrLongitude: releaseInfo.longitude,
				addrLatitude: releaseInfo.latitude,
				province: releaseInfo.province,
				city: releaseInfo.city
			},
			async: true,
			dataType: "json",
			success: function(data) {
				if (data.code == 1) {
					if (data.message.length > 0) {
						localStorage.removeItem('local');
						return callback();
					} else {
						return callback('服务错误');
					}
				} else {
					return callback(data.message);
				}
			},
			error: function(data) {
				//				alert(data.status);
				if (data.status == '401') {
					$.openWindow({
						url: 'login.html',
						id: 'login'
					});
					return;
				}
				return callback('服务错误!');
			}
		});
	};
	/**
	 * 订单查询(状态为空查所有)
	 **/
	owner.ordersQuery = function(orderInfo, callback) {
		callback = callback || $.noop;

		var state = JSON.parse(localStorage.getItem('$state'));
		mui.ajax({
			type: "post",
			url: baseUrl + "getOrders",
			data: {
				name: state.account,
				token: state.token,
				pageIndex: orderInfo.pageIndex,
				pageSize: orderInfo.pageSize,
				orderFieldStr: orderInfo.orderFieldStr,
				orderDirectionStr: orderInfo.orderDirectionStr,
				userId: orderInfo.userId,
				status: orderInfo.status,
				title: orderInfo.title,
				cateName: orderInfo.cateName,
				orderReceiver: orderInfo.orderReceiver,
				city: orderInfo.city
			},
			async: false,
			dataType: "json",
			success: function(data) {
				if (data.code == 1) {
					if (data.message.length > 0) {
						return callback(data);
					} else {
						mui.toast('服务错误');
						return callback();
					}
				} else {
					mui.toast(data.message);
					return callback();
				}
			},
			error: function(data) {
				if (data.status == '401') {
					$.openWindow({
						url: 'login.html',
						id: 'login'
					});
					return;
				}
				mui.toast('服务错误!');
				return callback();
			}
		});
	};
	/**
	 * 抢单 
	 **/
	owner.ordersGrab = function(orderNum, callback) {
		callback = callback || $.noop;

		var state = JSON.parse(localStorage.getItem('$state'));
		mui.ajax({
			type: "post",
			url: baseUrl + "orderGrab",
			data: {
				name: state.account,
				token: state.token,
				orderNum: orderNum,
				orderReceiver: state.account
			},
			async: true,
			dataType: "json",
			success: function(data) {
				if (data.code == 1) {
					if (data.message.length > 0) {
						return callback(data);
					} else {
						mui.toast('服务错误');
						return callback();
					}
				} else {
					mui.toast(data.message);
					return callback();
				}
			},
			error: function(data) {
				if (data.status == '401') {
					$.openWindow({
						url: 'login.html',
						id: 'login'
					});
					return;
				}
				mui.toast('服务错误!');
				return callback();
			}
		});
	};
	/**
	 * 订单状态操作（userid，orderReceiver，status）
	 */
	owner.orderStatus = function(orderNum, status,callback) {
		callback = callback || $.noop;

		var state = JSON.parse(localStorage.getItem('$state'));
		mui.ajax({
			type: "post",
			url: baseUrl + "orderStatus",
			data: {
				name: state.account,
				token: state.token,
				orderNum: orderNum,
				status: status,
				userId: state.userId,
				orderReceiver: state.userId
			},
			async: true,
			dataType: "json",
			success: function(data) {
				if (data.code == 1) {
					if (data.message.length > 0) {
						return callback(data);
					} else {
						mui.toast('服务错误');
						return callback();
					}
				} else {
					mui.toast(data.message);
					return callback();
				}
			},
			error: function(data) {
				if (data.status == '401') {
					$.openWindow({
						url: 'login.html',
						id: 'login'
					});
					return;
				}
				mui.toast('服务错误!');
				return callback();
			}
		});
	}
	/**
	 * 状态显示
	 * @param {Object} status
	 */
	owner.statusShow = function(status) {
			if (status == 1) {
				return '抢单';
			}
			if (status == 2) {
				return '已接单';
			}
			if (status == 3) {
				return '已取消';
			}
			if (status == 4) {
				return '取消待确认';
			}
			if (status == 5) {
				return '完成';
			}
			if (status == 6) {
				return '完成待确认';
			}
			if (status == 7) {
				return '取消待确认';
			}
		}
		/**
		 *判断是否为手机号 
		 */
	owner.getPhone = function() {
		var stateText = localStorage.getItem('$state') || "{}";
		var state = JSON.parse(stateText);
		if (myreg.test(state.account)) {
			return state.account;
		} else {
			return '';
		}
	};
	/**
	 *关闭键盘 
	 */
	owner.closeKeyBoard = function() {
			var win_height = window.innerHeight;
			var current_height = window.innerHeight
			var InputMethodManager = plus.android.importClass("android.view.inputmethod.InputMethodManager");

			var main = plus.android.runtimeMainActivity();
			var Context = plus.android.importClass("android.content.Context");
			if (win_height > current_height) {
				var imm = main.getSystemService(Context.INPUT_METHOD_SERVICE);
				imm.toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS);
			}

		}
		/**
		 * 日期格式化
		 * @param {Object} now
		 */
	owner.formatDate = function(now) {
		var year = now.getYear();
		var month = now.getMonth() + 1;
		var date = now.getDate();
		var hour = now.getHours();
		var minute = now.getMinutes();
		var second = now.getSeconds();
		return month + "." + date + "    " + hour + ":" + minute; //year + "-" ++ ":" + second;
	}
	owner.createState = function(userId, name, password, nickName, token, callback) {
		var state = owner.getState();
		state.userId = userId;
		state.account = name;
		state.password = password;
		state.nickname = nickName;
		state.token = token;
		owner.setState(state);
		return callback();
	};
	/**
	 * 获取当前状态
	 **/
	owner.getState = function() {
		var stateText = localStorage.getItem('$state') || "{}";
		return JSON.parse(stateText);
	};

	/**
	 * 设置当前状态
	 **/
	owner.setState = function(state) {
		state = state || {};
		localStorage.setItem('$state', JSON.stringify(state));
		//var settings = owner.getSettings();
		//settings.gestures = '';
		//owner.setSettings(settings);
	};

	var checkEmail = function(email) {
		email = email || '';
		return (email.length > 3 && email.indexOf('@') > -1);
	};

	/**
	 * 获取应用本地配置
	 **/
	owner.setSettings = function(settings) {
		settings = settings || {};
		localStorage.setItem('$settings', JSON.stringify(settings));
	}

	/**
	 * 设置应用本地配置
	 **/
	owner.getSettings = function() {
			var settingsText = localStorage.getItem('$settings') || "{}";
			return JSON.parse(settingsText);
		}
		/**
		 * 获取本地是否安装客户端
		 **/
	owner.isInstalled = function(id) {
		if (id === 'qihoo' && mui.os.plus) {
			return true;
		}
		if (mui.os.android) {
			var main = plus.android.runtimeMainActivity();
			var packageManager = main.getPackageManager();
			var PackageManager = plus.android.importClass(packageManager)
			var packageName = {
				"qq": "com.tencent.mobileqq",
				"weixin": "com.tencent.mm",
				"sinaweibo": "com.sina.weibo"
			}
			try {
				return packageManager.getPackageInfo(packageName[id], PackageManager.GET_ACTIVITIES);
			} catch (e) {}
		} else {
			switch (id) {
				case "qq":
					var TencentOAuth = plus.ios.import("TencentOAuth");
					return TencentOAuth.iphoneQQInstalled();
				case "weixin":
					var WXApi = plus.ios.import("WXApi");
					return WXApi.isWXAppInstalled()
				case "sinaweibo":
					var SinaAPI = plus.ios.import("WeiboSDK");
					return SinaAPI.isWeiboAppInstalled()
				default:
					break;
			}
		}
	}
}(mui, window.app = {}));