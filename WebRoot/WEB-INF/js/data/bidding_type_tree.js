/**
 * Created by Administrator on 2015/2/10.
 */
var biddingTypeData = [
    {
        "id": "1",
        "dictNo": "1",
        "dictOrder": 1,
        "name": "勘察设计类",
        "isParent": true,
        "children": [
            {
                "id": "11",
                "dictNo": "11",
                "dictOrder": 1,
                "isParent": true,
                "name": "设计",
                "children": [
                    {
                        "id": "111",
                        "dictNo": "111",
                        "dictOrder": 1,
                        "isParent": true,
                        "name": "总体总包全线设计",
                        "children": [
                            {
                                "id": "1111",
                                "dictNo": "1111",
                                "dictOrder": 1,

                                "name": "总体总包及全部设计项目"
                            }
                        ]
                    },
                    {
                        "id": "112",
                        "dictNo": "112",
                        "dictOrder": 2,
                        "isParent": true,
                        "name": "总体总包及部分分项设计",
                        "children": [
                            {
                                "id": "1121",
                                "dictNo": "1121",
                                "dictOrder": 1,
                                "name": "总体总包及部分分项设计"
                            },
                            {
                                "id": "1122",
                                "dictNo": "1122",
                                "dictOrder": 2,
                                "name": "分项设计（土建）"
                            },
                            {
                                "id": "1123",
                                "dictNo": "1123",
                                "dictOrder": 3,
                                "name": "分项设计（机电）"
                            }
                        ]
                    }
                ]
            },
            {
                "id": "12",
                "dictNo": "12",
                "dictOrder": 2,
                "isParent": true,
                "name": "勘察",
                "children": [
                    {
                        "id": "121",
                        "dictNo": "121",
                        "dictOrder": 1,
                        "isParent": true,
                        "name": "车站及区间详勘",
                        "children": [
                            {
                                "id": "1211",
                                "dictNo": "1211",
                                "dictOrder": 1,
                                "name": "车站/区间"
                            }
                        ]
                    },
                    {
                        "id": "123",
                        "dictNo": "123",
                        "dictOrder": 2,
                        "isParent": true,
                        "name": "车站详勘",
                        "children": [
                            {
                                "id": "1231",
                                "dictNo": "1231",
                                "dictOrder": 1,
                                "name": "水文地质勘察"
                            }
                        ]
                    },
                    {
                        "id": "122",
                        "dictNo": "122",
                        "dictOrder": 3,
                        "isParent": true,
                        "name": "停车场（车辆段）详勘",
                        "children": [
                            {
                                "id": "1221",
                                "dictNo": "1221",
                                "dictOrder": 1,
                                "name": "段场"
                            }
                        ]
                    }
                ]
            }
        ]
    },
    {
        "id": "2",
        "dictNo": "2",
        "dictOrder": 2,
        "name": "施工类",
        "isParent": true,
        "children": [
            {
                "id": "21",
                "dictNo": "21",
                "dictOrder": 1,
                "isParent": true,
                "name": "土建",
                "children": [
                    {
                        "id": "211",
                        "dictNo": "211",
                        "dictOrder": 1,
                        "isParent": true,
                        "name": "车站及区间",
                        "children": [
                            {
                                "id": "2111",
                                "dictNo": "2111",
                                "dictOrder": 1,
                                "name": "车站"
                            },
                            {
                                "id": "2112",
                                "dictNo": "2112",
                                "dictOrder": 2,
                                "name": "区间"
                            },
                            {
                                "id": "2113",
                                "dictNo": "2113",
                                "dictOrder": 3,
                                "name": "车站及区间"
                            }
                        ]
                    },
                    {
                        "id": "212",
                        "dictNo": "212",
                        "dictOrder": 2,
                        "isParent": true,
                        "name": "车站装修",
                        "children": [
                            {
                                "id": "2121",
                                "dictNo": "2121",
                                "dictOrder": 1,
                                "name": "车站装修"
                            },
                            {
                                "id": "2122",
                                "dictNo": "2122",
                                "dictOrder": 2,
                                "name": "车站装修及安装"
                            }
                        ]
                    },
                    {
                        "id": "213",
                        "dictNo": "213",
                        "dictOrder": 3,
                        "isParent": true,
                        "name": "停车场",
                        "children": [
                            {
                                "id": "2131",
                                "dictNo": "2131",
                                "dictOrder": 1,
                                "name": "房建"
                            },
                            {
                                "id": "2132",
                                "dictNo": "2132",
                                "dictOrder": 2,
                                "name": "市政"
                            },
                            {
                                "id": "2133",
                                "dictNo": "2133",
                                "dictOrder": 3,
                                "name": "绿化"
                            },
                            {
                                "id": "2134",
                                "dictNo": "2134",
                                "dictOrder": 4,
                                "name": "房建及市政"
                            }

                        ]
                    },
                    {
                        "id": "214",
                        "dictNo": "214",
                        "dictOrder": 4,
                        "name": "主变电所土建(不含电力外线）"
                    },
                    {
                        "id": "215",
                        "dictNo": "215",
                        "dictOrder": 5,
                        "name": "轨道"
                    },
                    {
                        "id": "216",
                        "dictNo": "216",
                        "dictOrder": 6,
                        "name": "导向标志"
                    },
                    {
                        "id": "217",
                        "dictNo": "217",
                        "dictOrder": 7,
                        "name": "声屏障"
                    },
                    {
                        "id": "218",
                        "dictNo": "218",
                        "dictOrder": 8,
                        "name": "道路"
                    },
                    {
                        "id": "219",
                        "dictNo": "219",
                        "dictOrder": 9,
                        "name": "桥梁"
                    },
                    {
                        "id": "21A",
                        "dictNo": "21A",
                        "dictOrder": 10,
                        "name": "区间旁通道"
                    },
                    {
                        "id": "21B",
                        "dictNo": "21B",
                        "dictOrder": 11,
                        "name": "监测",
                        "isParent": true,
                        "children": [
                            {
                                "id": "21B1",
                                "dictNo": "21B1",
                                "dictOrder": 1,
                                "name": "环境监测"
                            },
                            {
                                "id": "21B2",
                                "dictNo": "21B2",
                                "dictOrder": 2,
                                "name": "轴线复测"
                            },
                            {
                                "id": "21B3",
                                "dictNo": "21B3",
                                "dictOrder": 3,
                                "name": "材料检测"
                            },
                            {
                                "id": "21B4",
                                "dictNo": "21B4",
                                "dictOrder": 4,
                                "name": "桩基检测"
                            },
                            {
                                "id": "21B5",
                                "dictNo": "21B5",
                                "dictOrder": 5,
                                "name": "钢轨探伤"
                            },
                            {
                                "id": "21B6",
                                "dictNo": "21B6",
                                "dictOrder": 6,
                                "name": "后期沉降监测"
                            }
                        ]
                    },
                    {
                        "id": "21C",
                        "dictNo": "21C",
                        "dictOrder": 12,
                        "name": "预制构件",
                        "isParent": true,
                        "children": [
                            {
                                "id": "21C1",
                                "dictNo": "21C1",
                                "dictOrder": 1,
                                "name": "梁制作"
                            },
                            {
                                "id": "21C2",
                                "dictNo": "21C2",
                                "dictOrder": 2,
                                "name": "管片"
                            },
                            {
                                "id": "21C3",
                                "dictNo": "21C3",
                                "dictOrder": 3,
                                "name": "预制轨枕"
                            }
                        ]
                    },
                    {
                        "id": "21D",
                        "dictNo": "21D",
                        "dictOrder": 13,
                        "name": "出入口顶盖"
                    },
                    {
                        "id": "21F",
                        "dictNo": "31F",
                        "dictOrder": 114,
                        "name": "水系调整"
                    },
                    {
                        "id": "21E",
                        "dictNo": "21E",
                        "dictOrder": 15,
                        "name": "其他"
                    }
                ]
            },
            {
                "id": "22",
                "dictNo": "22",
                "dictOrder": 2,
                "isParent": true,
                "name": "机电",
                "children": [
                    {
                        "id": "221",
                        "dictNo": "211",
                        "dictOrder": 1,
                        "name": "车站风水电设备"
                    },
                    {
                        "id": "222",
                        "dictNo": "222",
                        "dictOrder": 2,
                        "name": "主变电所设备"
                    },
                    {
                        "id": "223",
                        "dictNo": "223",
                        "dictOrder": 3,
                        "name": "通信（含PIS、传输系统、CCTV)"
                    },
                    {
                        "id": "224",
                        "dictNo": "224",
                        "dictOrder": 4,
                        "name": "无线通信（直放站、漏缆、手持台）"
                    },
                    {
                        "id": "225",
                        "dictNo": "225",
                        "dictOrder": 5,
                        "name": "信号"
                    },
                    {
                        "id": "226",
                        "dictNo": "226",
                        "dictOrder": 6,
                        "name": "防灾报警/设备监控/门警系统"
                    },
                    {
                        "id": "227",
                        "dictNo": "227",
                        "dictOrder": 7,
                        "name": "气体灭火"
                    },
                    {
                        "id": "228",
                        "dictNo": "228",
                        "dictOrder": 8,
                        "name": "接触网/干线电缆/防迷流"
                    },
                    {
                        "id": "229",
                        "dictNo": "229",
                        "dictOrder": 9,
                        "name": "自动售检票设备"
                    },
                    {
                        "id": "22A",
                        "dictNo": "22A",
                        "dictOrder": 10,
                        "name": "牵引/降压变电所"
                    },
                    {
                        "id": "22B",
                        "dictNo": "22B",
                        "dictOrder": 11,
                        "name": "屏蔽门（安全门）"
                    },
                    {
                        "id": "22C",
                        "dictNo": "22C",
                        "dictOrder": 12,
                        "name": "停车场(车辆段)工艺设备"
                    },
                    {
                        "id": "22D",
                        "dictNo": "22D",
                        "dictOrder": 13,
                        "name": "防灾报警/设备监控/门警系统/气体灭火"
                    },
                    {
                        "id": "22E",
                        "dictNo": "22E",
                        "dictOrder": 14,
                        "name": "接触网/干线电缆/防迷流/牵引/降压变电所"
                    }
                ]
            }
        ]
    },
    {
        "id": "3",
        "dictNo": "3",
        "dictOrder": 3,
        "name": "监理类",
        "isParent": true,
        "children": [
            {
                "id": "31",
                "dictNo": "31",
                "dictOrder": 1,
                "name": "土建",
                "isParent": true,
                "children": [
                    {
                        "id": "311",
                        "dictNo": "311",
                        "dictOrder": 1,
                        "name": "车站及区间（含地下区间旁通道）"
                    },
                    {
                        "id": "312",
                        "dictNo": "312",
                        "dictOrder": 2,
                        "name": "停车场（市政、房建、绿化）"
                    },
                    {
                        "id": "313",
                        "dictNo": "313",
                        "dictOrder": 3,
                        "name": "主变电所"
                    },
                    {
                        "id": "314",
                        "dictNo": "314",
                        "dictOrder": 4,
                        "name": "轨道"
                    },
                    {
                        "id": "315",
                        "dictNo": "315",
                        "dictOrder": 5,
                        "name": "声屏障"
                    },
                    {
                        "id": "316",
                        "dictNo": "316",
                        "dictOrder": 6,
                        "name": "道路"
                    },
                    {
                        "id": "317",
                        "dictNo": "317",
                        "dictOrder": 7,
                        "name": "桥梁"
                    },
                    {
                        "id": "318",
                        "dictNo": "318",
                        "dictOrder": 8,
                        "name": "人防门/防火门"
                    },
                    {
                        "id": "319",
                        "dictNo": "319",
                        "dictOrder": 9,
                        "name": "预制构件",
                        "isParent": true,
                        "children": [
                            {
                                "id": "3191",
                                "dictNo": "3191",
                                "dictOrder": 1,
                                "name": "梁制作"
                            },
                            {
                                "id": "3192",
                                "dictNo": "3192",
                                "dictOrder": 2,
                                "name": "管片"
                            }
                        ]
                    },
                    {
                        "id": "31B",
                        "dictNo": "31B",
                        "dictOrder": 10,
                        "name": "水系调整"
                    },
                    {
                        "id": "31A",
                        "dictNo": "31A",
                        "dictOrder": 11,
                        "name": "其他"
                    }
                ]
            },
            {
                "id": "32",
                "dictNo": "32",
                "dictOrder": 2,
                "name": "机电",
                "isParent": true,
                "children": [
                    {
                        "id": "321",
                        "dictNo": "321",
                        "dictOrder": 1,
                        "name": "车站装修、风水电设备安装"
                    },
                    {
                        "id": "322",
                        "dictNo": "322",
                        "dictOrder": 2,
                        "name": "通信（含PIS、传输系统、CCTV)，含无线"
                    },
                    {
                        "id": "323",
                        "dictNo": "323",
                        "dictOrder": 3,
                        "name": "信号"
                    },
                    {
                        "id": "324",
                        "dictNo": "324",
                        "dictOrder": 4,
                        "name": "气体灭火/防灾报警/设备监控/门警系统"
                    },
                    {
                        "id": "325",
                        "dictNo": "325",
                        "dictOrder": 5,
                        "name": "接触网/干线电缆/防迷流"
                    },
                    {
                        "id": "326",
                        "dictNo": "326",
                        "dictOrder": 6,
                        "name": "自动售检票设备"
                    },
                    {
                        "id": "327",
                        "dictNo": "327",
                        "dictOrder": 7,
                        "name": "屏蔽门/安全门/自动扶梯/垂直电梯"
                    },
                    {
                        "id": "328",
                        "dictNo": "328",
                        "dictOrder": 8,
                        "name": "牵引/降压变电所"
                    },
                    {
                        "id": "329",
                        "dictNo": "329",
                        "dictOrder": 9,
                        "name": "停车场/车辆段工艺设备"
                    },
                    {
                        "id": "32A",
                        "dictNo": "32A",
                        "dictOrder": 10,
                        "name": "防灾报警/设备监控/门警系统/气体灭火"
                    },
                    {
                        "id": "32B",
                        "dictNo": "32B",
                        "dictOrder": 11,
                        "name": "接触网/干线电缆/防迷流/牵引/降压变电所"
                    },
                    {
                        "id": "32C",
                        "dictNo": "32C",
                        "dictOrder": 12,
                        "name": "停车场/车辆段工艺设备/屏蔽门/安全门/自动扶梯/垂直电梯"
                    },
                    {
                        "id": "32D",
                        "dictNo": "32D",
                        "dictOrder": 13,
                        "name": "其他"
                    }


                ]
            }
        ]
    },
    {
        "id": "4",
        "dictNo": "4",
        "dictOrder": 4,
        "name": "采购类",
        "isParent": true,
        "children": [

            {
                "id": "41",
                "dictNo": "41",
                "dictOrder": 1,
                "name": "土建",
                "isParent": true,
                "children": [
                    {
                        "id": "411",
                        "dictNo": "411",
                        "dictOrder": 1,
                        "name": "轨道",
                        "isParent": true,
                        "children": [
                            {
                                "id": "4111",
                                "dictNo": "4111",
                                "dictOrder": 1,
                                "name": "扣件"
                            }
                        ]
                    },
                    {
                        "id": "412",
                        "dictNo": "412",
                        "dictOrder": 2,
                        "name": "装饰材料",
                        "isParent": true,
                        "children": [
                            {
                                "id": "4121",
                                "dictNo": "4121",
                                "dictOrder": 1,
                                "name": "顶部材料"
                            },
                            {
                                "id": "4122",
                                "dictNo": "4122",
                                "dictOrder": 2,
                                "name": "墙面材料"
                            },
                            {
                                "id": "4123",
                                "dictNo": "4123",
                                "dictOrder": 3,
                                "name": "地面材料"
                            },
                            {
                                "id": "4124",
                                "dictNo": "4124",
                                "dictOrder": 4,
                                "name": "灯具"
                            },
                            {
                                "id": "4125",
                                "dictNo": "4125",
                                "dictOrder": 5,
                                "name": "防火门"
                            },
                            {
                                "id": "4126",
                                "dictNo": "4126",
                                "dictOrder": 6,
                                "name": "人防门"
                            },
                            {
                                "id": "4127",
                                "dictNo": "4127",
                                "dictOrder": 7,
                                "name": "客服中心"
                            }
                        ]
                    },
                    {
                        "id": "413",
                        "dictNo": "413",
                        "dictOrder": 3,
                        "name": "辅助设施",
                        "isParent": true,
                        "children": [
                            {
                                "id": "4131",
                                "dictNo": "4131",
                                "dictOrder": 1,
                                "name": "座椅、垃圾箱"
                            }
                        ]
                    }
                ]
            },
            {
                "id": "42",
                "dictNo": "42",
                "dictOrder": 2,
                "name": "机电",
                "isParent": true,
                "children": [
                    {
                        "id": "421",
                        "dictNo": "421",
                        "dictOrder": 1,
                        "name": "车辆",
                        "children": [
                            {
                                "id": "4211",
                                "dictNo": "4211",
                                "dictOrder": 1,
                                "name": "整车采购"
                            },
                            {
                                "id": "4212",
                                "dictNo": "4212",
                                "dictOrder": 2,
                                "name": "电气传动系统"
                            }
                        ]
                    },
                    {
                        "id": "422",
                        "dictNo": "422",
                        "dictOrder": 2,
                        "name": "信号"
                    },
                    {
                        "id": "423",
                        "dictNo": "423",
                        "dictOrder": 3,
                        "name": "停车场工艺设备"
                    },
                    {
                        "id": "424",
                        "dictNo": "424",
                        "dictOrder": 4,
                        "name": "主变电所",
                        "isParent": true,
                        "children": [
                            {
                                "id": "4241",
                                "dictNo": "4241",
                                "dictOrder": 1,
                                "name": "110KV GIS(台/间隔)"
                            },
                            {
                                "id": "4242",
                                "dictNo": "4242",
                                "dictOrder": 2,
                                "name": "110KV/35KV 变压器"
                            },
                            {
                                "id": "4243",
                                "dictNo": "4243",
                                "dictOrder": 3,
                                "name": "35KV GIS"
                            }
                        ]
                    },
                    {
                        "id": "425",
                        "dictNo": "425",
                        "dictOrder": 5,
                        "name": "牵引降压变电所",
                        "isParent": true,
                        "children": [
                            {
                                "id": "2451",
                                "dictNo": "2451",
                                "dictOrder": 1,
                                "name": "35KV GIS开关"
                            },
                            {
                                "id": "4252",
                                "dictNo": "4252",
                                "dictOrder": 2,
                                "name": "1500V 直流开关"
                            },
                            {
                                "id": "4253",
                                "dictNo": "4253",
                                "dictOrder": 3,
                                "name": "1500V 整流变压器"
                            },
                            {
                                "id": "4254",
                                "dictNo": "4254",
                                "dictOrder": 4,
                                "name": "400V 开关柜"
                            },
                            {
                                "id": "4255",
                                "dictNo": "4255",
                                "dictOrder": 5,
                                "name": "35KV/400V 动力变压器"
                            },
                            {
                                "id": "4256",
                                "dictNo": "4256",
                                "dictOrder": 6,
                                "name": "400V有缘滤波及无功补偿装置"
                            },
                            {
                                "id": "4257",
                                "dictNo": "4257",
                                "dictOrder": 7,
                                "name": "UPS装置"
                            }
                        ]
                    },
                    {
                        "id": "426",
                        "dictNo": "426",
                        "dictOrder": 6,
                        "name": "环控",
                        "isParent": true,
                        "children": [
                            {
                                "id": "4261",
                                "dictNo": "4261",
                                "dictOrder": 1,
                                "name": "单向轴流风机"
                            },
                            {
                                "id": "4262",
                                "dictNo": "4262",
                                "dictOrder": 2,
                                "name": "可逆轴流风机"
                            },
                            {
                                "id": "4266",
                                "dictNo": "4266",
                                "dictOrder": 3,
                                "name": "单向轴流风机及可逆轴流风机"
                            },
                            {
                                "id": "4263",
                                "dictNo": "4263",
                                "dictOrder": 4,
                                "name": "组合式空调箱"
                            },
                            {
                                "id": "4267",//"42A",
                                "dictNo": "4267",//"42A",
                                "dictOrder": 5,
                                "name": "复合风管"
                            },
                            {
                                "id": "4268",//"42B",
                                "dictNo": "4268",//"42B",
                                "dictOrder": 6,
                                "name": "综合桥架"
                            },
                            {
                                "id": "4264",
                                "dictNo": "4264",
                                "dictOrder":7,
                                "name": "冷水机组"
                            },
                            {
                                "id": "4265",
                                "dictNo": "4265",
                                "dictOrder": 8,
                                "name": "冷却塔"
                            }
                        ]
                    },
                    {
                        "id": "427",
                        "dictNo": "427",
                        "dictOrder": 7,
                        "name": "动力照明",
                        "isParent": true,
                        "children": [
                            {
                                "id": "4271",
                                "dictNo": "4271",
                                "dictOrder": 1,
                                "name": "环控电控柜"
                            },
                            {
                                "id": "4272",
                                "dictNo": "4272",
                                "dictOrder": 2,
                                "name": "部分动力柜"
                            },
                            {
                                "id": "4273",
                                "dictNo": "4273",
                                "dictOrder": 3,
                                "name": "变频柜"
                            }
                        ]
                    },
                    {
                        "id": "428",
                        "dictNo": "428",
                        "dictOrder": 8,
                        "name": "自动售检票",
                        "isParent": true,
                        "children": [
                            {
                                "id": "4281",
                                "dictNo": "4281",
                                "dictOrder": 1,
                                "name": "售票机/检票机"
                            },
                            {
                                "id": "4282",
                                "dictNo": "4282",
                                "dictOrder": 2,
                                "name": "票卡"
                            }
                        ]
                    },
                    {
                        "id": "429",
                        "dictNo": "429",
                        "dictOrder": 9,
                        "name": "电梯",
                        "isParent": true,
                        "children": [
                            {
                                "id": "4291",
                                "dictNo": "4291",
                                "dictOrder": 1,
                                "name": "自动扶梯"
                            },
                            {
                                "id": "4292",
                                "dictNo": "4292",
                                "dictOrder": 2,
                                "name": "垂直电梯"
                            },
                            {
                                "id": "4293",
                                "dictNo": "4293",
                                "dictOrder": 3,
                                "name": "自动扶梯及垂直电梯"
                            }
                        ]
                    }
                ]
            }
        ]
    },
    {
        "id": "5",
        "dictNo": "5",
        "dictOrder": 5,
        "name": "其他类"
    }
];
