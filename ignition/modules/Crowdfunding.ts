import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const CrowdfundingModule = buildModule("CrowdfundingModule", (m) => {
  const crowdfunding = m.contract("Fundraiser", [200]);
 
    return { crowdfunding };
  
});

export default CrowdfundingModule;