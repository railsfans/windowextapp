Ext.onReady(function() {
        var broswer="";
		    var platform="";	    
		    if(Ext.isIE){ 	
		        if(Ext.isIE6){
		            broswer = "Internet Explorer 6.x"
		        }else if(Ext.isIE7){
		            broswer = "Internet Explorer 7.x"
		        }else if(Ext.isIE8){
		            broswer = "Internet Explorer 8.x"
		        }
		    }else if(Ext.isSafari){
		        if(Ext.isSafari2){
		            broswer = "Safari 2.x"
		        }else if(Ext.isSafari3){
		           broswer = "Safari 3.x"
		        }else if(Ext.	isSafari4){
		            broswer = "Safari 4.x"
		        }
		    }else if(Ext.isChrome){
		        broswer = "Chrome"
		    }else if(Ext.isGecko){
		        broswer = "Firefox"
		        if(Ext.isGecko2){
		            broswer = "Firefox 2.x"
		        }else if(Ext.isGecko3){
		            broswer = "Firefox 3.x"
		        }
		    }else if(Ext.isOpera){
		        broswer = "Opera"
		    }else if(Ext.isWebKit){
		        broswer = "WebKit"
		    }else{
		        broswer = "unknown"
		    }    
		    if(Ext.isWindows){
		        platform = "Windows"
		    }else if(Ext.isLinux){
		        platform = "Linux"
		    }else if(Ext.isMac){
		        platform = "Mac OS"
		    }else{
		        broswer = "unknown"
		    }	
		    $("#platform").text(platform);	
		    $("#broswer").text(broswer);
		    
		    Ext.regModel("OrgInfo", {
		    fields: ['parent_id','name', 'code']
		    });
				var myStore = new Ext.data.TreeStore({
					model : 'OrgInfo',
					nodeParam : 'parent_id', 
					proxy: {
			            type: 'ajax',
			            url: 'code/all.json',
			            reader: 'json'
			        },
					autoLoad: true,
		        root: {
		            name: 'codelist',
		            id: 1
		        }
				});
		
	
		
		function alertMsg(record)
		{
/*			Ext.Msg.alert('tips','success');

        	var codedatas = [
					[100,'three',24],
					[200,'four',30],
					[300,'five',29]
		      ];
	
	var codegrid =	Ext.create('Ext.grid.Panel',{
			title : 'Grid example',
			frame:true,
			viewConfig: {
				forceFit : true,
	            stripeRows: true
	        },
			store: {
		        fields: ['id','name','age'],
		        proxy: {
		            type: 'memory',
		            data : codedatas,
		            reader : 'array'
		        },
		        autoLoad: true
		    },
			columns: [
				{header: "id", width: 30, dataIndex: 'id', sortable: true},
				{header: "name", width: 80, dataIndex: 'name', sortable: true},
				{header: "age", width: 80, dataIndex: 'age', sortable: true}
			],
			tbar: [
         { xtype: 'button', text: 'Button 1' },
         {text: 'new'}, {text: 'open'},
	    {text: 'edit'}, {text: 'save'},
	    '-', 
	    {
	    	xtype: 'textfield',
	    	hideLabel: true,
	    	width: 150
	    },
	    '->', 
	    '<a href=#>hyperlink</a>',
	    {
	    	xtype: 'tbspacer', 
	    	width: 50
	    },
	    'static text'
      ]
		});
*/
//        Ext.Msg.alert('tips','success');
        Ext.Ajax.request({
             url: 'code/list.js',
//             disableCaching:false,
             success: function(response){
                show_tip_message("success!");
                eval(response.responseText)
             },
             failure: function(response){
                  show_tip_message("false!")
             },
             params: { id : record }
         });

		};
		
    
		var tree_panel = Ext.create('Ext.tree.Panel', {
		//    title: 'example',
		    listeners: {
    'itemclick': function( grid, record, item, index, e, eOpts) {
        console.log(grid, record, item, index, e, eOpts);
        if(record.get('parent_id')!=0 && record.get('parent_id')!=1 && record.get('code').length!=4){
  //      alertMsg(record.get('id'));
      }
    }
    },
		    useArrows: true,
		    renderTo: 'tree',
		    columns: [{
	  	      xtype: 'treecolumn', 
		        text: 'code array',
		        dataIndex: 'name',
		        width: 150,
		        sortable: true
		    }, {
		        text: 'code',
		        dataIndex: 'code',
		        flex: 1,
		        sortable: true
		    }],
		    store : myStore,
		    rootVisible: true,
		    border: false,
	      autoScroll : true,
	      containerScroll: true,
   //     bodyBorder: true,
   //     frame: true
		}); 
    
    tree_panel.on('itemcontextmenu', function(view, record, item, index, event){
             alert(record.get('parent_id'));
             		var menu1 = new Ext.menu.Menu({
					        items: [
					                {
					                text: 'add a node', iconCls:"silk-user_add", handler: function() {
                    user_action_handler("add")
                }
					            },
					             {
					                text: 'edit a node', iconCls:"silk-user_add", handler: function() {
                    user_action_handler("edit")
                }
					            },
					             {
					                text: 'remove a node', iconCls:"silk-user_add", handler: function() {
                    user_action_handler("remove")
                }
					            }
					        ],
					         listeners : {
					        'click' : function() {
					           
					        }
					    }
					    }); 
					    
					    function user_action_handler(type){
					     alert(record.get('parent_id'));//tried item.text here but not working
					     console.log(record.get('code').length, record.get('parent_id'), record.get('id'), record.get('code'));
					     if(record.get('parent_id')=='' || record.get('parent_id')==1 || record.get('code').length==2)
					     {
		            Ext.Ajax.request({
						    url: 'code/get.js',
						//  params: {parent_id: record.get('parent_id'), type: type, id: record.get('id'), code: record.get('code'), name: record.get('name')},
						    success: function(response){
                        show_tip_message("success");
                        eval(response.responseText)
                    },
                failure: function(response) {
                        show_tip_message("false")
                    }                
                });
              }
              else {
              	alert("you are in wrong degree");
              }
					    }
					    
					    
            //treePanelCurrentNode = record;
            menu1.showAt(event.getXY());
            event.stopEvent();
    },this);
		    
        Ext.QuickTips.init();
   
        var viewport = Ext.create('Ext.Viewport', {
            id: 'border-example',
            layout: 'border',
            items: [
            Ext.create('Ext.Component', {
                region: 'north',
                height: 32, 
                contentEl: 'header'
            }), {
                region: 'south',
                contentEl: 'footer',
                height: 20,
            }, 
            {
                region: 'west',
                stateId: 'navigation-panel',
                id: 'menu', // see Ext.getCmp() below
                title: 'West',
                split: true,
                width: 200,
                minWidth: 175,
                maxWidth: 400,
                collapsible: true,
                animCollapse: true,
                margins: '0 0 0 5',
                layout: 'accordion',
                items: [{
                    contentEl: 'vehicle-management',
                    title: 'Navigation',
                    iconCls: 'nav', // see the HEAD section for style used
                    autoScroll: true
                }, {
                	  contentEl: 'user-management',
                    title: 'Settings',
                //    html: '<p>Some settings in here.</p>',
                    iconCls: 'settings', 
                    autoScroll: true
                }, {
                    title: 'Information',
                 //   html: '<p>Some info in here.</p>',
                    iconCls: 'info',
                    contentEl: 'tree',
                    autoScroll: true
                }]
            },
           {
                region: 'center', // a center region is ALWAYS required for border layout
                id: "work-space",
                border:true,
                layout:"fit",
                items: [     
                 {
                    contentEl: 'home-page',
                    title: 'Center Panel',
                    autoScroll: true
                }]
            }]
        });
     
       
        


$(".left-menu a:not('.selected')").bind('click', function (e) {

    Ext.getCmp("work-space").removeAll();

    Ext.Ajax.request({

        url: $(this).attr("href"),

        method: "GET",

        success: function(response){},

        failure: function(response){

            show_tip_message("failure!")

        }

    });

    $(".left-menu a").removeClass("selected");

    $(this).addClass("selected");

});

$(".left-menu a.selected").bind('click', function (e) {
    Ext.Msg.alert('tips','success');
    e.preventDefault();

});

});
   

