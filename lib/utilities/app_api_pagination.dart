class AppApiPagination {
  static bool hasMorePages({required int? page, required int? total}) {
    if (page! < total! || page == total) {
      return true;
    }
    return false;
  }

  static int getPageReq({required int? page, required int? total}) {
    if (page! < total!) {
      return page;
    }
    return total;
  }
}
