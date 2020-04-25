#ifndef LLDB_TOOLS_INTEL_PT_PROCESSOR_TRACE_STEPPING_H
#define LLDB_TOOLS_INTEL_PT_PROCESSOR_TRACE_STEPPING_H

#include "../trace/PTManager.h"
#include "ProcessorTraceCommand.h"
#include "lldb/API/SBCommandInterpreter.h"
#include "lldb/API/SBCommandReturnObject.h"
#include "lldb/API/SBDebugger.h"

enum PTSteppingKind {
  eStepInst = 0,
  eStepOver,
  eReverseStepInst,
  eReverseStepOver,
};

class ProcessorTraceCommandStepping : public ProcessorTraceCommand {
public:
  ProcessorTraceCommandStepping(
      std::shared_ptr<intelpt::PTManager> &pt_decoder, PTSteppingKind stepping_kind);

  bool DoExecute(lldb::SBDebugger debugger, char **command,
                 lldb::SBCommandReturnObject &result) override;

private:
  std::shared_ptr<intelpt::PTManager> pt_decoder_sp;
  PTSteppingKind m_stepping_kind;
};

class ProcessorTraceReverseStepInst: public ProcessorTraceCommandStepping {
public:
 ProcessorTraceReverseStepInst(std::shared_ptr<intelpt::PTManager> &pt_decoder): ProcessorTraceCommandStepping(pt_decoder, eReverseStepInst) {}

 const char *GetCommandName() { return "reverse-step-inst"; }

 const char *GetAlias() { return "ptrsi"; }

 const char *GetHelp() {
   return "Move the trace position to the previous instruction.";
 }
 const char *GetSyntax() {
   return "processor-trace reverse-step-inst <cmd-options>\n\n"
         "\rcmd-options Usage:\n"
         "\r  processor-trace reverse-step-in -t [<thread-index>]\n\n"
         "\t\b-t <thread-index>\n"
         "\t    thread index of the thread. If no threads are specified, "
         "the currently selected thread is taken.\n";
 }
};

#endif // LLDB_TOOLS_INTEL_PT_PROCESSOR_TRACE_STEPPING_H
