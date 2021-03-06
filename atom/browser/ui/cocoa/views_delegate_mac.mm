// Copyright (c) 2018 GitHub, Inc.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

#include "atom/browser/ui/cocoa/views_delegate_mac.h"

#include "content/public/browser/context_factory.h"
#include "ui/views/widget/native_widget_mac.h"

namespace atom {

ViewsDelegateMac::ViewsDelegateMac() {}

ViewsDelegateMac::~ViewsDelegateMac() {}

void ViewsDelegateMac::OnBeforeWidgetInit(
    views::Widget::InitParams* params,
    views::internal::NativeWidgetDelegate* delegate) {
  // If we already have a native_widget, we don't have to try to come
  // up with one.
  if (params->native_widget)
    return;

  if (!native_widget_factory().is_null()) {
    params->native_widget = native_widget_factory().Run(*params, delegate);
    if (params->native_widget)
      return;
  }

  // Setting null here causes Widget to create the default NativeWidget
  // implementation.
  params->native_widget = nullptr;
}

ui::ContextFactory* ViewsDelegateMac::GetContextFactory() {
  return content::GetContextFactory();
}

ui::ContextFactoryPrivate* ViewsDelegateMac::GetContextFactoryPrivate() {
  return content::GetContextFactoryPrivate();
}

}  // namespace atom
