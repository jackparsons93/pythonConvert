#!/usr/bin/python
#coding=utf-8


from yandex_translate import YandexTranslate
translate = YandexTranslate('trnsl.1.1.20180731T232407Z.2d3b500877260736.d6a4b1322b8071c460e3c3b8eab22c210dcc6c06')
#print('Languages:', translate.langs)
#print('Translate directions:', translate.directions)
print('Detect language:', translate.detect('元気でーす でも外暑すぎて死にそう'))
print('Translate:', translate.translate('ただ芋', 'en'))  # or just 'en'
