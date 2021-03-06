//===- AArch64LegalizerInfo --------------------------------------*- C++ -*-==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
/// \file
/// This file declares the targeting of the Machinelegalizer class for
/// AArch64.
/// \todo This should be generated by TableGen.
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_AARCH64_AARCH64MACHINELEGALIZER_H
#define LLVM_LIB_TARGET_AARCH64_AARCH64MACHINELEGALIZER_H

#include "llvm/CodeGen/GlobalISel/GISelChangeObserver.h"
#include "llvm/CodeGen/GlobalISel/LegalizerInfo.h"

namespace llvm {

class LLVMContext;
class AArch64Subtarget;

/// This class provides the information for the target register banks.
class AArch64LegalizerInfo : public LegalizerInfo {
public:
  AArch64LegalizerInfo(const AArch64Subtarget &ST);

  bool legalizeCustom(MachineInstr &MI, MachineRegisterInfo &MRI,
                      MachineIRBuilder &MIRBuilder,
                      GISelChangeObserver &Observer) const override;

private:
  bool legalizeVaArg(MachineInstr &MI, MachineRegisterInfo &MRI,
                     MachineIRBuilder &MIRBuilder) const;
  bool legalizeLoadStore(MachineInstr &MI, MachineRegisterInfo &MRI,
                         MachineIRBuilder &MIRBuilder,
                         GISelChangeObserver &Observer) const;
  bool legalizeShlAshrLshr(MachineInstr &MI, MachineRegisterInfo &MRI,
                           MachineIRBuilder &MIRBuilder,
                           GISelChangeObserver &Observer) const;
};
} // End llvm namespace.
#endif
