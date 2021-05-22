/*
@filename: enemyInd.hpp
Author:

	BACONMOP

Description:
	Units, vehicles and groups, for use elsewhere in the mission.
	Also allows greater control over what is being spawned, and where, yet allows for random composition groups.

	Sentry = 2-man
	Team = 4-man
	Squad = 8-man
__________________________________________________*/

class VC {
        class squad1 {
            class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "vn_o_men_vc_regional_01";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "vn_o_men_vc_regional_02";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "vn_o_men_vc_regional_03";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "vn_o_men_vc_regional_04";
            };
        };
	class squad2 {
		class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "vn_o_men_vc_regional_05";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "vn_o_men_vc_regional_06";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "vn_o_men_vc_regional_07";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "vn_o_men_vc_regional_08";
            };
		};
	class squad3 {
		class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "vn_o_men_vc_regional_09";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "vn_o_men_vc_regional_10";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "vn_o_men_vc_regional_11";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "vn_o_men_vc_regional_12";
            };
		};
};

