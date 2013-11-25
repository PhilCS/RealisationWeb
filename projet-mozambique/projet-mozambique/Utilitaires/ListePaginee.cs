using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace projet_mozambique.Utilitaires
{
    public class ListePaginee<T> : List<T>
    {
        public int PageIndex  { get; private set; }
        public int PageSize   { get; private set; }
        public int TotalCount { get; private set; }
        public int TotalPages { get; private set; }
 
        public ListePaginee(List<T> source, int pageIndex, int pageSize) 
        {
            PageIndex = pageIndex;
            PageSize = pageSize;
            TotalCount = source.Count();
            TotalPages = (int) Math.Ceiling(TotalCount / (double)PageSize);
 
            this.AddRange(source.Skip(PageIndex * PageSize).Take(PageSize));
        }
 
        public bool HasPreviousPage 
        {
            get { return (PageIndex > 0); }
        }
 
        public bool HasNextPage 
        {
            get { return (PageIndex+1 < TotalPages); }
        }

        public bool ShowFirstPage
        {
            get { return PageIndex > 1; }
        }

        public bool ShowLastPage
        {
            get { return (PageIndex + 2) < TotalPages;  }
        }

        public bool ShowPagination
        {
            get { return HasNextPage || HasPreviousPage; }
        }

    }
}