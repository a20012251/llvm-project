#include "Instruction.h"

#include "intel-pt.h"

using namespace intelpt_private;

Instruction::Instruction()
    : ip(0), data(), m_error_code(pte_invalid), iclass(ptic_error), speculative(0) {}

Instruction::Instruction(const struct pt_insn &insn)
    : ip(insn.ip), data(), m_error_code(0),
      iclass(insn.iclass), speculative(insn.speculative) {
  if (insn.size != 0)
    data.assign(insn.raw, insn.raw + insn.size);
}

Instruction::Instruction(int error_code)
    : ip(0), data(), m_error_code(error_code), iclass(ptic_error),
      speculative(0) {}

Instruction::~Instruction() {}

lldb::addr_t Instruction::GetInsnAddress() const { return ip; }

size_t Instruction::GetRawBytes(void *buf, size_t size) const {
  if ((buf == nullptr) || (size == 0))
    return data.size();

  size_t bytes_to_read = ((size <= data.size()) ? size : data.size());
  ::memcpy(buf, data.data(), bytes_to_read);
  return bytes_to_read;
}

pt_insn_class Instruction::GetInsnClass() const { return iclass; }

const char *Instruction::GetError() const { return pt_errstr(pt_errcode(m_error_code)); }

bool Instruction::IsError() const {
  return m_error_code != 0;
}

bool Instruction::GetSpeculative() const { return speculative; }

size_t Instruction::GetSize() const { return data.size(); }

InstructionList::InstructionList() : m_insn_vec() {}

InstructionList::InstructionList(const InstructionList &insn_list)
    : m_insn_vec(insn_list.m_insn_vec) {}

InstructionList::~InstructionList() {}

// Get number of instructions in the list
size_t InstructionList::GetSize() const { return m_insn_vec.size(); }

// Get instruction at index
Instruction InstructionList::GetInstructionAtIndex(uint32_t idx) {
  return (idx < m_insn_vec.size() ? m_insn_vec[idx]
                                  : Instruction());
}

// Append intruction at the end of the list
void InstructionList::AppendInstruction(Instruction inst) {
  m_insn_vec.push_back(inst);
}
