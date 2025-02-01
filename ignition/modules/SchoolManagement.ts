import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const SchoolManagement = buildModule("SchoolManagementModule", (m) => {
  const schoolManagement = m.contract("SchoolManagement");
  return { schoolManagement };
});

export default SchoolManagement;