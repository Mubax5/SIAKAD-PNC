<?php

use CodeIgniter\Router\RouteCollection;


$routes->get('/', 'Home::index');


$routes->post('api/auth/login', 'ApiController::login');
$routes->get('api/user/profile/(:num)', 'ApiController::getUser/$1');
$routes->get('api/user/matkul/(:num)', 'ApiController::getMatkul/$1');
$routes->get('api/user/presensi/(:num)', 'ApiController::getPresensi/$1');
$routes->post('api/user/presensi/mark/(:num)', 'ApiController::markPresensiCepat/$1');
$routes->get('api/user/tugas-akhir/(:num)', 'ApiController::getTugasAkhir/$1');
$routes->get('api/user/nilai-transkrip/(:num)', 'ApiController::getNilaiTranskrip/$1');
$routes->get('api/user/surat/(:num)', 'ApiController::getSurat/$1');
$routes->get('api/user/keuangan/(:num)', 'ApiController::getKeuangan/$1');
$routes->post('api/user/keuangan/bayar/(:num)', 'ApiController::bayarKeuangan/$1');
$routes->get('api/user/mbkm/(:num)', 'ApiController::getMbkm/$1');
