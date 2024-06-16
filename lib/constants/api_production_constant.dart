import 'package:flutter/material.dart';

class ApiProductionConstant {
  ApiProductionConstant._();

  static String getSumberBatok() {
    return 'sumber_batok';
  }

  static String getBatok(String filter) {
    return 'batok?filter=$filter';
  }

  static String postBatok() {
    debugPrint('STORE BATOK ENDPOINT');
    return 'store/batok';
  }

  static String updateBatok(int id) {
    debugPrint('UPDATE BATOK ENDPOINT');
    return 'update/batok/$id';
  }

  static String deleteBatok(int id) {
    return 'delete/batok/$id';
  }

  //* BAHAN BAKU
  static String getBahanBaku(String filter) {
    return 'bahan_baku?filter=$filter';
  }

  static String postBahanBaku() {
    return 'store/bahan_baku';
  }

  static String updateBahanBaku(int id) {
    return 'update/bahan_baku/$id';
  }

  static String deleteBahanBaku(int id) {
    return 'delete/bahan_baku/$id';
  }

  static String exportBatok() {
    return 'batok/export';
  }

  static String exportBahanBaku() {
    return 'bahan_baku/export';
  }

  static String exportAyakManual() {
    return 'ayak_manual/export';
  }

  static String exportAyakRotari() {
    return 'ayak_rotari/export';
  }

  static String exportDiskmill() {
    return 'diskmill/export';
  }

  static String exportMixing() {
    return 'mixing/export';
  }

  static String exportOven() {
    return 'oven/export';
  }

  static String exportBriket() {
    return 'briket/export';
  }
}
