// @(#)root/tree:$Id$
// Author: Axel Naumann, 2010-10-12

/*************************************************************************
 * Copyright (C) 1995-2013, Rene Brun and Fons Rademakers.               *
 * All rights reserved.                                                  *
 *                                                                       *
 * For the licensing terms see $ROOTSYS/LICENSE.                         *
 * For the list of contributors see $ROOTSYS/README/CREDITS.             *
 *************************************************************************/

#ifndef ROOT_TTreeReaderUtils
#define ROOT_TTreeReaderUtils


////////////////////////////////////////////////////////////////////////////
//                                                                        //
// TTreeReaderUtils                                                       //
//                                                                        //
// TTreeReader's helpers.                                                 //
//                                                                        //
//                                                                        //
////////////////////////////////////////////////////////////////////////////

#include "TBranchProxyDirector.h"
#include "TBranchProxy.h"
#include "TTreeReaderValue.h"

#include <string>

class TDictionary;
class TTree;

namespace ROOT {
   namespace Detail {
      class TBranchProxy;
   }

namespace Internal {
   class TBranchProxyDirector;
   class TTreeReaderArrayBase;

   class TNamedBranchProxy {
   public:
      TNamedBranchProxy() : fDict(nullptr), fContentDict(nullptr) {}
      TNamedBranchProxy(TBranchProxyDirector *boss, TBranch *branch, const char *fullname, const char *membername,
                        bool suppressMissingBranchError)
         : fProxy(boss, fullname, branch, membername, suppressMissingBranchError),
           fDict(nullptr),
           fContentDict(nullptr),
           fFullName(fullname)
      {
      }

      // Constructor for friend case, the fullname (containing the name of the friend tree) may be different
      // from the lookup name (without the name of the friend)
      TNamedBranchProxy(TBranchProxyDirector *boss, TBranch *branch, const char *fullname, const char *proxyname,
                        const char *membername, bool suppressMissingBranchError)
         : fProxy(boss, proxyname, branch, membername, suppressMissingBranchError),
           fDict(nullptr),
           fContentDict(nullptr),
           fFullName(fullname)
      {
      }

      const char* GetName() const { return fFullName.c_str(); }
      const Detail::TBranchProxy* GetProxy() const { return &fProxy; }
      Detail::TBranchProxy* GetProxy() { return &fProxy; }
      TDictionary* GetDict() const { return fDict; }
      void SetDict(TDictionary* dict) { fDict = dict; }
      TDictionary* GetContentDict() const { return fContentDict; }
      void SetContentDict(TDictionary* dict) { fContentDict = dict; }

   private:
      Detail::TBranchProxy fProxy;
      TDictionary*         fDict;
      TDictionary*         fContentDict; // type of content, if a collection
      std::string          fFullName;
   };

   // Used by TTreeReaderArray
   class TVirtualCollectionReader {
   public:
      TTreeReaderValueBase::EReadStatus fReadStatus;

      TVirtualCollectionReader() : fReadStatus(TTreeReaderValueBase::kReadNothingYet) {}

      virtual ~TVirtualCollectionReader();
      TVirtualCollectionReader(const TVirtualCollectionReader &) = delete;
      TVirtualCollectionReader &operator=(const TVirtualCollectionReader &) = delete;
      TVirtualCollectionReader(TVirtualCollectionReader &&) = delete;
      TVirtualCollectionReader &operator=(TVirtualCollectionReader &&) = delete;

      virtual size_t GetSize(Detail::TBranchProxy*) = 0;
      virtual void* At(Detail::TBranchProxy*, size_t /*idx*/) = 0;
      virtual bool IsContiguous(Detail::TBranchProxy *) = 0;
      virtual std::size_t GetValueSize(Detail::TBranchProxy *) = 0;
   };

}
}

#endif // defined TTreeReaderUtils
