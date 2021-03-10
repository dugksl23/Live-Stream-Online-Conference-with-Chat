﻿/*!
 * @license Copyright (c) 2003-2021, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md.
 */
//# sourceMappingURL=ckeditor.js.map






   var editor;

ClassicEditor
			.create( document.querySelector( '#content' ), {
				fontFamily: {
				            options: [
				                'default',
				                'Ubuntu, Arial, sans-serif',
				                'Ubuntu Mono, Courier New, Courier, monospace'
				            ],supportAllValues: true
				        	},
     			 fontSize: {
                            options: [
                                9,
                                11,
                                13,
                                'default',
                                17,
                                19,
                                21
                            ], supportAllValues: true
                        },

				toolbar: {
					items: [
						'heading',
						'fontFamily',
						'fontSize',
						'|',
						'fontColor',
						'fontBackgroundColor',
						'highlight',
						'bold',
						'italic',
						'underline',
						'alignment',
						'todoList',
						'bulletedList',
						'numberedList',
						'link',
						'|',
						'indent',
						'outdent',
						'|',
						//'ckfinder',
						'imageUpload',
						'blockQuote',
						'insertTable',
						'mediaEmbed',
						'undo',
						'redo'
					]
				},
				language: 'ko',
				image: {
					toolbar: [
						'imageTextAlternative',
						'imageStyle:full',
						'imageStyle:side'
					]
				},
				table: {
					contentToolbar: [
						'tableColumn',
						'tableRow',
						'mergeTableCells'
					]
				},
				
				ckfinder: {
	       	 		uploadUrl: '/file/upload' // 내가 지정한 업로드 url (post로 요청감)
				},
				simpleUpload: {
        			uploadUrl: '/file/upload',
					tokenUrl: 'https://example.com/cs-token-endpoint',
    			},
				
				alignment: {
            		options: [ 'left', 'center', 'right' ]
        		},
				
				
				
				licenseKey: '',
				
				
				
				
			} )
			.then( editor => {
				window.editor = editor;
			//editor 객체를 만든다는 것.
			//editor 객체를 상기의 editor 객체에 선언하고 
			// link를 통해 import한 후에 해당 객채에서 getData를 통해서 html값 가져올 수 있다.	
			
			//Window 객체
			//window 객체는 웹 브라우저의 창(window)을 나타내는 객체로, 대부분의 웹 브라우저에서 지원하고 있습니다.
			//자바스크립트의 모든 객체, 전역 함수, 전역 변수들은 자동으로 window 객체의 프로퍼티가 됩니다.
			//window 객체의 메소드는 전역 함수이며, window 객체의 프로퍼티는 전역 변수가 됩니다.
			//문서 객체 모델(DOM)의 요소들도 모두 window 객체의 프로퍼티가 됩니다.		
				
				
		
				
				
				
			} )
			.catch( error => {
				console.error( 'Oops, something went wrong!' );
				console.error( 'Please, report the following error on https://github.com/ckeditor/ckeditor5/issues with the build id and the error stack trace:' );
				console.warn( 'Build id: 696j8ul6jzfi-a580v7ob2of' );
				console.error( error );
			} );








